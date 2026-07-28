module tb;
    logic        clk;
    logic        rst_n;
    logic        start;
    logic [63:0] key_in;
    logic [31:0] plaintext;
    logic [31:0] ciphertext;
    logic        valid_out;

    // Instantiate Top-Level Device Under Test (DUT)
    speck32_64_top dut (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .key_in(key_in),
        .plaintext(plaintext),
        .ciphertext(ciphertext),
        .valid_out(valid_out)
    );

    // 100 MHz Clock Generator (10 ns period)
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        // Dump VCD file for EPWave waveform visualization
        $dumpfile("dump.vcd");
        $dumpvars(0, tb);

        // Apply Reset
        rst_n     = 1'b0;
        start     = 1'b0;
        key_in    = 64'h0;
        plaintext = 32'h0;

        #20;
        rst_n = 1'b1;
        #10;

        // Apply Mandatory Official Test Vector:
        // Key:       1918_1110_0908_0100
        // Plaintext: 6574_694c
        // Expected:  a868_42f2
        key_in    = 64'h1918_1110_0908_0100;
        plaintext = 32'h6574_694c;
        start     = 1'b1;

        #10;
        start     = 1'b0;

        // Wait for FSM to assert valid_out signal
        @(posedge valid_out);

        // Verify Output
        if (ciphertext === 32'ha868_42f2) begin
            $display("\n==================================================");
            $display("[PASS] SPECK32/64 Test Vector Matched!");
            $display("Ciphertext Result: %h", ciphertext);
            $display("==================================================\n");
        end else begin
            $display("\n==================================================");
            $display("[FAIL] Mismatch Detected!");
            $display("Expected: a86842f2");
            $display("Got:      %h", ciphertext);
            $display("==================================================\n");
        end

        #20;
        $finish;
    end
endmodule