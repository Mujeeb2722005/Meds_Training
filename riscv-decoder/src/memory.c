#include "memory.h"
#include <stdio.h>
#include <stdlib.h>

int load_hex_file(const char *filename, uint8_t *memory, size_t mem_size) {
    FILE *fp = fopen(filename, "r");
    if (!fp) {
        perror("Cannot open hex file"); 
        return -1;
    }

    char line[32];
    uint32_t addr = 0;
    
    
    while (fgets(line, sizeof(line), fp) && addr + 3 < mem_size) {
        uint32_t word = (uint32_t)strtoul(line, NULL, 16);
        
        
        memory[addr + 0] = (word >> 0) & 0xFF;
        memory[addr + 1] = (word >> 8) & 0xFF;
        memory[addr + 2] = (word >> 16) & 0xFF;
        memory[addr + 3] = (word >> 24) & 0xFF;
        addr += 4;
    }
    
    fclose(fp); 
    return (int)(addr / 4); 
}