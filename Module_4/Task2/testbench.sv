// ===== testbench.sv =====
module tb;
    logic a, b;
    logic y_and, y_or, y_xor;
    
    // 2-bit loop variable to sweep through 00, 01, 10, 11
    logic [1:0] ab; 

    // Instantiate the DUT
    logic_gates dut (
        .a(a), 
        .b(b), 
        .y_and(y_and), 
        .y_or(y_or), 
        .y_xor(y_xor)
    );

    // The check() 
    task automatic check(input logic actual, expected, string name);
        // Using !== to catch exact 4-state mismatches (including X and Z)
        if (actual !== expected)
            $display("[FAIL] %s: expected=%0b actual=%0b at time=%0t", name, expected, actual, $time);
        else
            $display("[PASS] %s: value=%0b at time=%0t", name, actual, $time);
    endtask

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb);

        $display("Starting Exhaustive Self-Check...");

        // Loop through all 4 combinations of a and b
        for (ab = 2'b00; ab <= 2'b11; ab = ab + 1) begin
            {a, b} = ab; // Unpack loop variable into inputs
            
            #10; // Wait for combinational logic to settle

            // Check each output against an independently calculated expected value
            check(y_and, (a & b), $sformatf("AND (a=%0b, b=%0b)", a, b));
            check(y_or,  (a | b), $sformatf("OR  (a=%0b, b=%0b)", a, b));
            check(y_xor, (a ^ b), $sformatf("XOR (a=%0b, b=%0b)", a, b));
        end
        
        $finish;
    end
endmodule