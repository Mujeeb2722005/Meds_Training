// ===== design.sv =====
module logic_gates (
    input  logic a, 
    input  logic b,
    output logic y_and,
    output logic y_or,
    output logic y_xor
);

    // Continuous assignments for all three gates
    assign y_and = a & b;
    assign y_or  = a | b;
    assign y_xor = a ^ b;

endmodule