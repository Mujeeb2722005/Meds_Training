// ===== design.sv =====
module nor_realization (
    input  logic a,
    input  logic b,
    input  logic c,
    input  logic d,
    output logic f_orig,
    output logic f_nor
);

    // 1. Direct assignment using the original expression
    assign f_orig = (b | c | d) & (~a | b | c) & (~a | d);

    // 2. Pure NOR assignment using the reduction NOR (~|) operator
    logic a_not, term1, term2, term3;
    
    // a' = a NOR a
    assign a_not = ~|{a, a};        
    
    // Inner NOR terms: (X + Y + Z)'
    assign term1 = ~|{b, c, d};     
    assign term2 = ~|{a_not, b, c}; 
    assign term3 = ~|{a_not, d};    
    
    // Outer NOR operation combining the terms
    assign f_nor = ~|{term1, term2, term3}; 

endmodule