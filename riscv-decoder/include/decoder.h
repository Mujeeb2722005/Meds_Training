#ifndef DECODER_H
#define DECODER_H

#include <stdint.h>
#include "common.h"
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