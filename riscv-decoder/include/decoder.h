#ifndef DECODER_H
#define DECODER_H

#include <stdint.h>
#include "common.h"
typedef enum {
    OP_R_TYPE = 0x33, OP_I_TYPE = 0x13, OP_LOAD = 0x03,
    OP_STORE = 0x23, OP_BRANCH = 0x63, OP_LUI = 0x37,
    OP_AUIPC = 0x17, OP_JAL = 0x6F, OP_JALR = 0x67
} opcode_t;

// Use the struct provided in the training manual [cite: 472]
typedef struct {
    uint32_t opcode;
    uint32_t rd;
    uint32_t funct3;
    uint32_t rs1;
    uint32_t rs2;
    uint32_t funct7;
    int32_t imm;
} decoded_instr_t;

// Prototype for the decoder function
void decode_instruction(uint32_t raw_instruction, decoded_instr_t *out);

#endif // DECODER_H