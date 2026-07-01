# Design Document: RISC-V RV32I Instruction Decoder

## Architecture Overview
The decoder follows a modular architecture to ensure a clean separation between data ingestion, instruction parsing, and output formatting.

## Component Breakdown
1. **Memory Module (`src/memory.c`)**:
   - Manages a 64KB heap-allocated memory block.
   - Responsible for loading raw hex data from files and reconstructing little-endian 32-bit instructions.

2. **Decoder Module (`src/decoder.c`)**:
   - **Instruction Representation**: Uses the `decoded_instr_t` struct to encapsulate all parsed fields (`opcode`, `rd`, `rs1`, `rs2`, `imm`, etc.).
   - **Parsing Logic**: Implements bit-masking macros to isolate instruction fields efficiently.
   - **Sign-Extension**: Utilizes a custom `sign_extend` function to correctly handle immediate values for I, S, B, and J instruction formats.
   - **Mnemonic Mapping**: Employs a central `switch` statement to map opcodes and function fields to RISC-V assembly mnemonics.

3. **Control Flow (`src/main.c`)**:
   - Orchestrates the instruction loading and decoding loop.
   - Handles output formatting, including conditional logic to display either register names or immediate values based on the instruction type.

## Key Design Decisions
- **Bit Manipulation**: Used pre-processor macros for bit extraction, maintaining high performance and code readability.
- **Robustness**: Implemented a `default` case in the mnemonic mapping that outputs `UNKNOWN` for invalid instructions, preventing system crashes.
- **Memory Safety**: Rigorously utilized `free()` on all heap allocations, achieving zero memory leaks as verified by `valgrind`.