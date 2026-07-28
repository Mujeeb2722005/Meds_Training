
//  SPECK Encryption Round Function (Combinational ALU)

module speck_round (
    input  logic [15:0] x_in,
    input  logic [15:0] y_in,
    input  logic [15:0] k_in,
    output logic [15:0] x_out,
    output logic [15:0] y_out
);
    logic [15:0] x_rotr;
    logic [15:0] y_rotl;

    // ROTR(x, 7)
    assign x_rotr = {x_in[6:0], x_in[15:7]};

    // x_{i+1} = (ROTR(x_i, 7) + y_i) ^ k_i
    assign x_out = (x_rotr + y_in) ^ k_in;

    // ROTL(y, 2)
    assign y_rotl = {y_in[13:0], y_in[15:14]};

    // y_{i+1} = ROTL(y_i, 2) ^ x_{i+1}
    assign y_out = y_rotl ^ x_out;
endmodule


//  SPECK Key Schedule Generator (Corrected Formula)

module speck_key_schedule (
    input  logic [15:0] l_in,       // l[i]
    input  logic [15:0] rk_in,      // RK[i]
    input  logic [4:0]  round_idx,  // Round index i
    output logic [15:0] l_out,      // l[i+3]
    output logic [15:0] rk_out      // RK[i+1]
);
    logic [15:0] l_rotr;
    logic [15:0] rk_rotl;

    // ROTR(l_i, 7) - Correction: Rotation applies to l_i, not RK_i
    assign l_rotr = {l_in[6:0], l_in[15:7]};

    // l[i+3] = (ROTR(l[i], 7) + RK[i]) ^ i
    assign l_out = (l_rotr + rk_in) ^ {11'b0, round_idx};

    // ROTL(RK[i], 2)
    assign rk_rotl = {rk_in[13:0], rk_in[15:14]};

    // RK[i+1] = ROTL(RK[i], 2) ^ l[i+3]
    assign rk_out = rk_rotl ^ l_out;
endmodule

// Top-Level Module: SPECK32/64 Datapath + Controller

module speck32_64_top (
    input  logic        clk,
    input  logic        rst_n,
    input  logic        start,
    input  logic [63:0] key_in,     // {k3, k2, k1, k0}
    input  logic [31:0] plaintext,  // {x0, y0}
    output logic [31:0] ciphertext,
    output logic        valid_out
);

    // FSM States Definition
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        LOAD = 2'b01,
        CALC = 2'b10,
        DONE = 2'b11
    } state_t;

    state_t current_state, next_state;

    // Registers
    logic [15:0] reg_x, reg_y;
    logic [15:0] reg_rk;
    logic [15:0] reg_l0, reg_l1, reg_l2;
    logic [4:0]  round_cnt;

    // Control Signals
    logic load_sel;
    logic update_en;

    // Combinational Output Wires
    logic [15:0] round_x_out, round_y_out;
    logic [15:0] ks_l_out, ks_rk_out;


    // Module Instantiations

    speck_round u_round (
        .x_in(reg_x),
        .y_in(reg_y),
        .k_in(reg_rk),
        .x_out(round_x_out),
        .y_out(round_y_out)
    );

    speck_key_schedule u_key_sched (
        .l_in(reg_l0),
        .rk_in(reg_rk),
        .round_idx(round_cnt),
        .l_out(ks_l_out),
        .rk_out(ks_rk_out)
    );

  
    // FSM Block 1: State Register (Sequential)
   
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    // FSM Block 2: Next-State Logic (Combinational)
    
    always_comb begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                if (start)
                    next_state = LOAD;
            end
            LOAD: begin
                next_state = CALC;
            end
            CALC: begin
                if (round_cnt == 5'd21)
                    next_state = DONE;
            end
            DONE: begin
                if (!start)
                    next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

   
    // FSM Block 3: Output Logic (Combinational)
  
    always_comb begin
        load_sel  = 1'b0;
        update_en = 1'b0;
        valid_out = 1'b0;

        case (current_state)
            IDLE: ;
            LOAD: begin
                load_sel  = 1'b1;
            end
            CALC: begin
                update_en = 1'b1;
            end
            DONE: begin
                valid_out = 1'b1;
            end
        endcase
    end


    // Datapath Register Updates & Round Counter

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            reg_x     <= 16'h0000;
            reg_y     <= 16'h0000;
            reg_rk    <= 16'h0000;
            reg_l0    <= 16'h0000;
            reg_l1    <= 16'h0000;
            reg_l2    <= 16'h0000;
            round_cnt <= 5'd0;
        end else if (load_sel) begin
            // Load initial values from inputs
            reg_x     <= plaintext[31:16];  // x0
            reg_y     <= plaintext[15:0];   // y0
            reg_rk    <= key_in[15:0];      // k0
            reg_l0    <= key_in[31:16];     // k1
            reg_l1    <= key_in[47:32];     // k2
            reg_l2    <= key_in[63:48];     // k3
            round_cnt <= 5'd0;
        end else if (update_en) begin
            // Advance cipher round and key schedule
            reg_x     <= round_x_out;
            reg_y     <= round_y_out;
            
            reg_rk    <= ks_rk_out;
            reg_l0    <= reg_l1;
            reg_l1    <= reg_l2;
            reg_l2    <= ks_l_out;

            round_cnt <= round_cnt + 1'b1;
        end
    end

    // Assign final ciphertext output
    assign ciphertext = {reg_x, reg_y};

endmodule