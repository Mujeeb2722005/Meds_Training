#ifndef COMMON_H
#define COMMON_H

#include <stdint.h>
#define NUM_REGISTERS 32
#define MEMORY_SIZE 65536
#define EXTRACT_BITS(val, high, low) (((val) >> (low)) & ((1U << ((high) - (low) + 1)) - 1))

#endif 