#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "memory.h"
#include "decoder.h"

int main(int argc, char *argv[]) {
    // Ensure a hex file argument is provided [cite: 794]
    if (argc < 2) {
        fprintf(stderr, "Usage: %s <hex file>\n", argv[0]);
        return EXIT_FAILURE; 
    }

    // Allocate 64KB zero-initialized memory as per module requirements [cite: 687, 879]
    uint8_t *memory = calloc(MEMORY_SIZE, 1);
    
    // Load the hex file [cite: 741]
    int words_loaded = load_hex_file(argv[1], memory, MEMORY_SIZE);

    if (words_loaded > 0) {
        printf("RISC-V RV32I Instruction Decoder\n");
        printf("Loaded %d instructions from %s\n\n", words_loaded, argv[1]);
        printf("%-12s  %-8s  %-7s  %s\n", "Addr", "Hex", "Assembly", "Args");

        // Loop through each loaded instruction [cite: 1171]
        for (int i = 0; i < words_loaded; i++) {
            // Reconstruct the 32-bit word from little-endian bytes [cite: 759, 760, 761]
            uint32_t raw = (memory[i*4+3] << 24) | (memory[i*4+2] << 16) | 
                           (memory[i*4+1] << 8) | (memory[i*4+0]);
            
            decoded_instr_t decoded;
            decode_instruction(raw, &decoded);
            
            char mnemonic[16];
            get_mnemonic(&decoded, mnemonic);
            
            // Format output to match the assignment requirements 
            if (strcmp(mnemonic, "UNKNOWN") == 0) {
                printf("0x%08X: %08X  UNKNOWN\n", i * 4, raw);
            } else {
                // Printing Assembly format 
                printf("0x%08X: %08X  %-7s  x%u, x%u, %d\n", 
                       i * 4, raw, mnemonic, decoded.rd, decoded.rs1, decoded.imm);
            }
        }
    } else {
        fprintf(stderr, "No instructions loaded or file read error.\n");
    }

    // Always free allocated memory to prevent leaks [cite: 691, 692]
    free(memory);
    return EXIT_SUCCESS;
}