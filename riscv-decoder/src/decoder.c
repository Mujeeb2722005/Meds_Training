#include "decoder.h"
#include <stdio.h>
#include <string.h>

// Decode the 32-bit instruction into a struct [cite: 72, 1145]
void decode_instruction(uint32_t raw_instruction, decoded_instr_t *out) {
    out->opcode = EXTRACT_BITS(raw_instruction, 6, 0);
    out->rd = EXTRACT_BITS(raw_instruction, 11, 7);
    out->funct3 = EXTRACT_BITS(raw_instruction, 14, 12);
    out->rs1 = EXTRACT_BITS(raw_instruction, 19, 15);
    out->rs2 = EXTRACT_BITS(raw_instruction, 24, 20);
    out->funct7 = EXTRACT_BITS(raw_instruction, 31, 25);
    
    // Sign-extend immediate based on instruction type 
    // Simplified logic provided here; expand for all types
    if (out->opcode == OP_I_TYPE) {
        out->imm = (int32_t)(raw_instruction >> 20); 
    } else {
        out->imm = 0;
    }
}

// Map opcode/funct3/funct7 to mnemonic [cite: 1144]
void get_mnemonic(decoded_instr_t *instr, char *buffer) {
    switch (instr->opcode) {
        case OP_R_TYPE:
            if (instr->funct3 == 0x0 && instr->funct7 == 0x00) strcpy(buffer, "add");
            else if (instr->funct3 == 0x0 && instr->funct7 == 0x20) strcpy(buffer, "sub");
            else if (instr->funct3 == 0x7) strcpy(buffer, "and");
            else strcpy(buffer, "R-TYPE");
            break;
        case OP_I_TYPE:
            if (instr->funct3 == 0x0) strcpy(buffer, "addi");
            else strcpy(buffer, "I-TYPE");
            break;
        case OP_LOAD:
            if (instr->funct3 == 0x2) strcpy(buffer, "lw");
            else strcpy(buffer, "LOAD");
            break;
        case OP_STORE:
            if (instr->funct3 == 0x2) strcpy(buffer, "sw");
            else strcpy(buffer, "STORE");
            break;
        case OP_BRANCH:
            if (instr->funct3 == 0x0) strcpy(buffer, "beq");
            else strcpy(buffer, "BRANCH");
            break;
        case OP_LUI: strcpy(buffer, "lui"); break;
        case OP_AUIPC: strcpy(buffer, "auipc"); break;
        case OP_JAL: strcpy(buffer, "jal"); break;
        case OP_JALR: strcpy(buffer, "jalr"); break;
        default:
            strcpy(buffer, "UNKNOWN"); // Requirement: Print UNKNOWN [cite: 1143]
            break;
    }
}