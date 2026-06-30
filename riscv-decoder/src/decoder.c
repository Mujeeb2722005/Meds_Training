#include "decoder.h"
#include <stdio.h>

void decode_instruction(uint32_t raw_instruction, decoded_instr_t *out) {
   
    out->opcode = EXTRACT_BITS(raw_instruction, 6, 0);

    out->rd = EXTRACT_BITS(raw_instruction, 11, 7);
    out->funct3 = EXTRACT_BITS(raw_instruction, 14, 12);
    out->rs1 = EXTRACT_BITS(raw_instruction, 19, 15);
    out->rs2 = EXTRACT_BITS(raw_instruction, 24, 20);
    out->funct7 = EXTRACT_BITS(raw_instruction, 31, 25);
    if (out->opcode == 0x13) { 
        out->imm = (int32_t)(raw_instruction >> 20);
    } else {
        out->imm = 0;
    }
}