// ===== design.sv =====
module parity_generator (
    input  logic [3:0] data,
    output logic       parity
);

    // Reduction XOR operator simplifies the entire vector to 1 bit
    assign parity = ^data;

endmodule