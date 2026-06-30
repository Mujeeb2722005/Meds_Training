#ifndef MEMORY_H
#define MEMORY_H

#include <stdint.h>
#include <stddef.h>
int load_hex_file(const char *filename, uint8_t *memory, size_t mem_size);

#endif // MEMORY_H