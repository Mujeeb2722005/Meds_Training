// ===== testbench.sv =====
module tb;
    logic a, b, c, d;
    logic f_orig, f_nor;

    // Use an integer to prevent infinite loop overflow
    int abcd; 

    // Instantiate the design module
    nor_realization dut (
        .a(a), 
        .b(b), 
        .c(c), 
        .d(d), 
        .f_orig(f_orig), 
        .f_nor(f_nor)
    );

    // Self-checking task
    task automatic check(input logic actual, expected, string name);
        if (actual !== expected)
            $display("[FAIL] %s: expected=%0b actual=%0b", name, expected, actual);
        else
            $display("[PASS] %s: value=%0b", name, actual);
    endtask

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb);

        $display("--- Testing NOR-Only Realization ---");
        
        // Exhaustively test all 16 combinations (2^4)
        for (abcd = 0; abcd <= 15; abcd = abcd + 1) begin
            // SystemVerilog extracts the bottom 4 bits of the integer
            {a, b, c, d} = abcd; 
            
            #10; // Allow combinational logic to settle
            
            // Check if the NOR implementation perfectly matches the original
            check(f_nor, f_orig, $sformatf("Match check for a=%0b, b=%0b, c=%0b, d=%0b", a, b, c, d));
        end

        $finish;
    end
endmodule