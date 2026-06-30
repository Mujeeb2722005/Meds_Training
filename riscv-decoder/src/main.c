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

    free(memory); 
    return EXIT_SUCCESS;
}