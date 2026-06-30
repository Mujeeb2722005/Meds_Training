#include <stdio.h>
#include <stdlib.h>
#include "memory.h"
#include "decoder.h"

int main(int argc, char *argv[]) {
    if (argc < 2) {
        fprintf(stderr, "Usage: %s <hex file>\n", argv[0]);
        return EXIT_FAILURE; 
    }

    uint8_t *memory = calloc(MEMORY_SIZE, 1); 
    int words_loaded = load_hex_file(argv[1], memory, MEMORY_SIZE);

    if (words_loaded > 0) {
        printf("Loaded %d instructions from %s\n", words_loaded, argv[1]);
    }

    for (int i = 0; i < words_loaded; i++) {
    uint32_t raw = (memory[i*4+3] << 24) | (memory[i*4+2] << 16) | 
                   (memory[i*4+1] << 8) | (memory[i*4+0]);
    
    decoded_instr_t decoded;
    decode_instruction(raw, &decoded);
    
    printf("0x%08X: 0x%08X | Opcode: 0x%02X, rd: x%u\n", 
           i * 4, raw, decoded.opcode, decoded.rd);
}

    free(memory); 
    return EXIT_SUCCESS;
}