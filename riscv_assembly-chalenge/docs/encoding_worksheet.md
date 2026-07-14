# Instruction Encoding Worksheet

**Course:** MEDS Lab Summer Training Programme 2026 (Cohort 4)   
**Module 3:** RISC-V Instruction Set Architecture   
**Task:** Hand-encoding 6 core RISC-V instructions (one for each basic format).  

---

## 1. R-Type Format (Register-Register)

**Instruction:** `add x4, x5, x10`   

**Target Fields:** * `opcode`: 0110011   
* `funct3`: 000   
* `funct7`: 0000000   
* `rd`: x4 -> 00100   
* `rs1`: x5 -> 00101   
* `rs2`: x10 -> 01010   

### Bit Breakdown

| funct7 (7b) | rs2 (5b) | rs1 (5b) | f3 (3b) |  rd (5b) | opcode (7b) |
| :---: | :---: | :---: | :---: | :---: | :---: |
| 0000000 | 01010 | 00101 | 000 | 00100 | 0110011 |

### Conversion to Hexadecimal
* **Binary:** `0000 0000 1010 0010 1000 0010 0110 0011`
* **Hex Value:** `0x00A28233`   

---

## 2. I-Type Format (Immediate / Arithmetic)

**Instruction:** `addi x2, x0, 5`   

**Target Fields:**
* `opcode`: 0010011   
* `funct3`: 000   
* `rd`: x2 -> 00010   
* `rs1`: x0 -> 00000   
* `imm[11:0]`: 5 -> 000000000101   

### Bit Breakdown

| imm[11:0] (12b) | rs1 (5b) | f3 (3b) |  rd (5b) | opcode (7b) |
| :---: | :---: | :---: | :---: | :---: |
| 000000000101 | 00000 | 000 | 00010 | 0010011 |

### Conversion to Hexadecimal
* **Binary:** `0000 0000 0101 0000 0000 0001 0001 0011`
* **Hex Value:** `0x00500113`   

---

## 3. S-Type Format (Stores)

**Instruction:** `sw x7, 8(x8)`   

**Target Fields:**
* `opcode`: 0100011   
* `funct3`: 010 (Word size store)   
* `rs1` (Base register): x8 -> 01000
* `rs2` (Source data): x7 -> 00111
* `imm[11:0]`: 8 -> Split into `imm[11:5]` = 0000000 and `imm[4:0]` = 01000   

### Bit Breakdown

| imm[11:5] (7b) | rs2 (5b) | rs1 (5b) | f3 (3b) | imm[4:0] (5b) | opcode (7b) |
| :---: | :---: | :---: | :---: | :---: | :---: |
| 0000000 | 00111 | 01000 | 010 | 01000 | 0100011 |

### Conversion to Hexadecimal
* **Binary:** `0000 0000 0111 0100 0010 0100 0010 0011`
* **Hex Value:** `0x00742423`

---

## 4. B-Type Format (Conditional Branches)

**Instruction:** `beq x1, x2, +16` (Target offset = +16 bytes from current PC)

**Target Fields:**
* `opcode`: 1100111 / Base: 1100011   
* `funct3`: 000 (BEQ code)   
* `rs1`: x1 -> 00001
* `rs2`: x2 -> 00010
* `imm`: 16 -> Binary representation (13 bits including explicit 0 at bit 0): `0 0000 0001 0000`
  * `imm[12]`: 0   
  * `imm[11]`: 0   
  * `imm[10:5]`: 000000   
  * `imm[4:1]`: 1000   

### Bit Breakdown

| imm[12] | imm[10:5] | rs2 (5b) | rs1 (5b) | f3 (3b) | imm[4:1] | imm[11] | opcode (7b) |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| 0 | 000000 | 00010 | 00001 | 000 | 1000 | 0 | 1100011 |

### Conversion to Hexadecimal
* **Binary:** `0000 0000 0010 0000 1000 1000 0110 0011`
* **Hex Value:** `0x00208863`

---

## 5. U-Type Format (Upper Immediate)

**Instruction:** `lui x5, 0x12345`   

**Target Fields:**
* `opcode`: 0110111   
* `rd`: x5 -> 00101
* `imm[31:12]`: 0x12345 -> 0001 0010 0011 0100 0101   

### Bit Breakdown

| imm[31:12] (20b) |  rd (5b) | opcode (7b) |
| :---: | :---: | :---: |
| 00010010001101000101 | 00101 | 0110111 |

### Conversion to Hexadecimal
* **Binary:** `0001 0010 0011 0100 0101 0010 1011 0111`
* **Hex Value:** `0x123452B7`

---

## 6. J-Type Format (Unconditional Jumps)

**Instruction:** `jal x1, +20` (Target offset = +20 bytes from current PC)

**Target Fields:**
* `opcode`: 1101111   
* `rd`: x1 -> 00001
* `imm`: 20 -> Binary representation (21 bits including explicit 0 at bit 0): `0 0000 0000 0000 0001 0100`
  * `imm[20]`: 0   
  * `imm[19:12]`: 0
  * `imm[11]`: 0   
  * `imm[10:1]`: 0000001010   

### Bit Breakdown

| imm[20] | imm[10:1] | imm[11] | imm[19:12] | rd (5b) | opcode (7b) |
| :---: | :---: | :---: | :---: | :---: | :---: |
| 0 | 0000001010 | 0 | 00000000 | 00001 | 1101111 |

### Conversion to Hexadecimal
* **Binary:** `0000 0001 0100 0000 0000 0000 1110 1111`
* **Hex Value:** `0x014000EF`

---

## Verification
All 6 computed hex values were loaded into `part3_encoding.s` and passed through bit-masking routines using the Venus simulator. The runtime extraction yields perfectly matched structural subfields, proving hardware-software equivalence.