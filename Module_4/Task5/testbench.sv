// ===== testbench.sv =====
module tb;
    logic [3:0] data;
    logic       parity;
    
    // Integer loop variable to prevent infinite loops
    int i; 

    // Instantiate the device under test (DUT)
    parity_generator dut (
        .data(data),
        .parity(parity)
    );

    // Self-checking task pattern
    task automatic check(input logic actual, expected, string name);
        if (actual !== expected)
            $display("[FAIL] %s: expected=%0b actual=%0b", name, expected, actual);
        else
            $display("[PASS] %s: value=%0b", name, actual);
    endtask

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb);

        $display("--- Testing 4-bit Parity Generator ---");

        // Sweep all 16 combinations (2^4)
        for (i = 0; i <= 15; i = i + 1) begin
            // Extract the lower 4 bits of the integer loop variable
            data = i; 
            
            #10; // Allow combinational logic to settle
            
            // $countones() returns the number of 1s in the variable.
            // Using modulo 2 (% 2) returns 1 if odd, and 0 if even.
            check(parity, ($countones(data) % 2), $sformatf("Parity of data=%04b", data));
        end

        $finish;
    end
endmodule