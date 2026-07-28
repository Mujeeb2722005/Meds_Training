// ===== testbench.sv =====
module tb;
    // Declare testbench signals
    logic a, b;
    logic y_and, y_or, y_xor;

    // Instantiate the design module (DUT) using named port connections
    logic_gates dut (
        .a(a), 
        .b(b), 
        .y_and(y_and), 
        .y_or(y_or), 
        .y_xor(y_xor)
    );

    initial begin
        // Mandatory for opening waveforms in EPWave
        $dumpfile("dump.vcd");
        $dumpvars(0, tb);
        
        $display("a b | AND OR XOR");
        $display("----|-----------");

        // Test Case 1: 0 0
        a = 0; b = 0; #10;
        $display("%0b %0b |  %0b   %0b   %0b", a, b, y_and, y_or, y_xor);

        // Test Case 2: 0 1
        a = 0; b = 1; #10;
        $display("%0b %0b |  %0b   %0b   %0b", a, b, y_and, y_or, y_xor);

        // Test Case 3: 1 0
        a = 1; b = 0; #10;
        $display("%0b %0b |  %0b   %0b   %0b", a, b, y_and, y_or, y_xor);

        // Test Case 4: 1 1
        a = 1; b = 1; #10;
        $display("%0b %0b |  %0b   %0b   %0b", a, b, y_and, y_or, y_xor);

        $finish;
    end
endmodule