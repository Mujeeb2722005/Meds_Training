# Lecture 2: Combinational Logic 

**Lecturer:** Prof. Onur Mutlu  
**Subject:** Digital Design and Computer Architecture  
**Focus:** Building blocks of modern computer architecture from transistors to functional modules.

---

## 1. Basics of Digital Circuits 

### Transistor Fundamentals
*   Modern digital logic is built using **n-type** and **p-type** transistors functioning as switches.
*   **CMOS (Complementary Metal-Oxide Semiconductor):** Logic designed so exactly one network (pull-up or pull-down) is on at a time to prevent short circuits.

### Power & Performance
*   **Static Power:** Power consumption due to leakage when transistors are inactive. 
*   **Dynamic Power:** Power consumed during the switching of logic states. 
*   Balancing these is critical for energy efficiency and hardware reliability. 

### Moore’s Law
*   Refers to the historical exponential growth of transistor density on chips. 
*   Evolution ranges from early integrated circuits to modern chips containing billions of transistors. 
---

## 2. Boolean Algebra & Logic Specification 

### Foundational Algebra
*   Uses an axiomatic system (AND, OR, NOT) to simplify complex logic functions. 

### Canonical Representations
*   **Sum of Products (SOP):** An OR of ANDed literals (Minterms). 
*   **Product of Sums (POS):** An AND of ORed literals (Maxterms). 
*   **Short-hand Notation:** Truth tables are compressed using decimal indices:
    *   **$\Sigma$ notation:** Represents Minterms. 
    *   **$\Pi$ notation:** Represents Maxterms. 

---

## 3. Combinational Logic Modules 

### Standard Modules
*   **Decoders:** Logic that converts input patterns into "one-hot" outputs (e.g., 2-to-4 decoder). 
*   **Multiplexers (Muxes):** Data selectors that pick one of several inputs based on control signals (e.g., 2-to-1, 4-to-1 Muxes). 
*   **Lookup Tables (LUTs):** Implementation of logic functions using Muxes or memory structures; central to FPGA design. 
*   **Programmable Logic Arrays (PLA):** Implements any Boolean function using structured AND-planes and OR-planes. 

### Arithmetic Logic: Adders
*   Binary adders are constructed using **Full Adders (FA)**. 
*   These are based on XOR operations for the sum and majority functions for the carry bit. 

---

## 4. Key Tables & Reference Data

### NAND Gate Truth Table
| A | B | Y (NAND) |
| :-: | :-: | :---: |
| 0 | 0 | 1 |
| 0 | 1 | 1 |
| 1 | 0 | 1 |
| 1 | 1 | 0 |


### Binary Adder Logic Table (Full Adder)
| A | B | $C_{in}$ | Sum (S) | Carry ($C_{out}$) |
| :-: | :-: | :-: | :-: | :-: |
| 0 | 0 | 0 | 0 | 0 |
| 0 | 1 | 0 | 1 | 0 |
| 1 | 0 | 0 | 1 | 0 |
| 1 | 1 | 0 | 0 | 1 |
| 0 | 0 | 1 | 1 | 0 |
| 0 | 1 | 1 | 0 | 1 |
| 1 | 0 | 1 | 0 | 1 |
| 1 | 1 | 1 | 1 | 1 |


---

## 5. Recommended Resources
*   **Harris & Harris:** Section 1.7 (Transistor Logic). 
*   **Moore, G. E. (1965):** *Cramming more components onto integrated circuits*. 
