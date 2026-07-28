// ===== design.sv =====

// 1. Half Adder using continuous 'assign'
module half_adder_assign (
    input  logic a,
    input  logic b,
    output logic sum,
    output logic carry
);
    // Dataflow style logic equations
    assign sum   = a ^ b;
    assign carry = a & b;
endmodule

// 2. Half Adder using procedural 'always_comb'
module half_adder_always (
    input  logic a,
    input  logic b,
    output logic sum,
    output logic carry
);
    // Behavioral style using case structure
    always_comb begin
        case ({a, b})
            2'b00: begin sum = 1'b0; carry = 1'b0; end
            2'b01: begin sum = 1'b1; carry = 1'b0; end
            2'b10: begin sum = 1'b1; carry = 1'b0; end
            2'b11: begin sum = 1'b0; carry = 1'b1; end
            // Always include a default branch to prevent inferred latches
            default: begin sum = 1'b0; carry = 1'b0; end 
        endcase
    end
endmodule

// 3. Full Adder using structural composition
module full_adder (
    input  logic a,
    input  logic b,
    input  logic cin,
    output logic sum,
    output logic cout
);
    // Internal wires to connect the blocks
    logic ha1_sum, ha1_carry;
    logic ha2_carry;

    // Instantiate First Half Adder (using the assign version)
    half_adder_assign ha1 (
        .a(a),
        .b(b),
        .sum(ha1_sum),
        .carry(ha1_carry)
    );

    // Instantiate Second Half Adder
    half_adder_assign ha2 (
        .a(ha1_sum),
        .b(cin),
        .sum(sum),
        .carry(ha2_carry)
    );

    // Final OR gate to combine the carry outputs
    assign cout = ha1_carry | ha2_carry;
endmodule