# Lecture 4: Sequential Logic, FPGAs, and Verilog

**Lecturer:** Prof. Onur Mutlu  
**Topics:** Sequential Design, Finite State Machines (FSM), Lab Logistics, and Hardware Description Languages (HDL).

---

## 1. Sequential Logic & Finite State Machines 

### Sequential Circuits
Unlike combinational circuits, sequential circuits possess **memory**. Their output is a function of both current inputs and the history of past inputs (stored as "state").

### State Elements: D Flip-Flops
* **Edge-Triggered:** The D flip-flop captures the value of the input (D) only at the **rising edge** of the clock.
* **Stability:** This mechanism ensures that the state remains stable between clock cycles, preventing logic races.

### Finite State Machines (FSMs)
A formal method for designing systems with state. An FSM consists of three primary components:
1.  **State Register:** Stores the current state (implemented using flip-flops).
2.  **Next-State Logic:** Combinational logic that determines what the next state should be based on current inputs and the current state.
3.  **Output Logic:** Combinational logic that produces the system's output.

#### Moore vs. Mealy Machines
* **Moore Machine:** The output is a function **only** of the current state.
* **Mealy Machine:** The output is a function of **both** the current state and the current inputs.

#### State Encoding
* **Binary/Fully Encoded:** Uses the minimum number of flip-flops ($\log_2 n$ for $n$ states).
* **One-Hot Encoding:** Each state has its own flip-flop; only one is "high" at a time. This often simplifies the next-state and output logic but uses more flip-flops.

---

## 2. Lab Logistics & FPGAs 

### FPGAs (Field Programmable Gate Arrays)
FPGAs are integrated circuits designed to be configured by a customer after manufacturing.
* **Substrate:** They consist of programmable logic blocks called **Lookup Tables (LUTs)** and programmable interconnects.
* **Applications:** Used extensively for hardware acceleration in genomics, bioinformatics, and memory security research (e.g., RowHammer studies).

## 3. Hardware Description Languages & Verilog 

### The Role of HDLs
Modern chips contain billions of transistors; manual schematic entry is impossible. HDLs like **Verilog** and **VHDL** allow for high-level architectural modeling.

### Concurrency: Hardware vs. Software
* **Software (C/C++):** Executes instructions sequentially, line by line.
* **Hardware (Verilog):** Models **parallel** operations. Every line of a combinational assignment executes simultaneously in hardware.

### Verilog Module Basics
The fundamental unit in Verilog is the `module`.
* **Ports:** Definition of `input` and `output` signals.
* **Logic:** Internal logic can be defined using `assign` statements (combinational) or `always` blocks (sequential/state-driven).

---
*Reference: Digital Design and Computer Architecture - Prof. Onur Mutlu.*
