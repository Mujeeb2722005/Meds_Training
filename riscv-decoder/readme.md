# RISC-V Instruction Decoder

## Project Description
An automated, C-based instruction decoding and diagnostic tool designed to parse RISC-V RV32I machine code into structured assembly reports. This framework reconstructs instructions from binary hex files, handles field extraction, performs sign-extension for immediate values, and generates organized diagnostic output.

## Build Instructions
Ensure you have `gcc` and `make` installed.
1. Compile the project:
   ```bash
   make
   make test
   ## Sample Output
```text
Addr        Hex         Assembly
----------  ----------  ------------------------------
0x00000000  00500113    addi    x2, x0, 5
0x00000004  00A00193    addi    x3, x0, 10
0x00000008  003100B3    add     x1, x2, x3
Decoded 3 instructions (3 valid, 0 unknown)
```