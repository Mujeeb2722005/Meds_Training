// ===== testbench.sv =====
module tb;
    // Signals for Half Adders
    logic a, b;
    logic sum_assign, carry_assign;
    logic sum_always, carry_always;
    
    // Signals for Full Adder
    logic cin;
    logic fa_sum, fa_cout;

    // SOLUTION: Changed from 'logic' to 'int' to prevent infinite loop overflow
    int ab;
    int abc;

    // Instantiate Half Adder (assign version)
    half_adder_assign dut_ha_assign (
        .a(a), .b(b), .sum(sum_assign), .carry(carry_assign)
    );

    // Instantiate Half Adder (always_comb version)
    half_adder_always dut_ha_always (
        .a(a), .b(b), .sum(sum_always), .carry(carry_always)
    );

    // Instantiate Full Adder
    full_adder dut_fa (
        .a(a), .b(b), .cin(cin), .sum(fa_sum), .cout(fa_cout)
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

        $display("--- Testing Half Adders (assign vs always_comb) ---");
        // Loop using the integer
        for (ab = 0; ab <= 3; ab = ab + 1) begin
            {a, b} = ab; // SystemVerilog automatically extracts the bottom 2 bits
            #10; // Wait for combinational logic to settle
            
            // Confirm identical outputs from both implementations
            if ({sum_assign, carry_assign} === {sum_always, carry_always})
                $display("[PASS] HA Match for a=%0b, b=%0b -> sum=%0b, carry=%0b", 
                         a, b, sum_assign, carry_assign);
            else
                $display("[FAIL] HA Mismatch for a=%0b, b=%0b!", a, b);
        end

        $display("\n--- Testing Full Adder (Structural Composition) ---");
        // Loop using the integer
        for (abc = 0; abc <= 7; abc = abc + 1) begin
            {a, b, cin} = abc; // Automatically extracts the bottom 3 bits
            #10;
            
            // Expected mathematical logic for a full adder
            check(fa_sum,  (a ^ b ^ cin),                 $sformatf("FA Sum  (a=%0b,b=%0b,cin=%0b)", a, b, cin));
            check(fa_cout, ((a & b) | (b & cin) | (a & cin)), $sformatf("FA Cout (a=%0b,b=%0b,cin=%0b)", a, b, cin));
        end

        $finish;
    end
endmodule