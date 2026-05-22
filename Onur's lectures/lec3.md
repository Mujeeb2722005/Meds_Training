# Lecture 3: Sequential Logic 

**Course:** Computer Architecture  
**Lecturer:** Prof. Onur Mutlu  
**Focus:** Transitioning from Combinational Logic to State-Driven Systems.


## Part 1: Completing Combinational Logic 

### Programmable Logic Arrays (PLA)
A PLA is a flexible hardware structure used to implement any Boolean function in **Sum-of-Products (SOP)** form. 
- It consists of a programmable **AND-plane** followed by a programmable **OR-plane**.
- This enables the implementation of complex logic without the need for discrete gates for every specific function.

### Combinational Blocks & Functional Units
- **4-bit Comparator:** A circuit that compares two binary numbers to determine equality or relative magnitude.
- **Arithmetic Logic Unit (ALU):** The core of the processor that performs arithmetic (addition, subtraction) and logical operations. Mutlu emphasizes the use of **Two's Complement** to simplify subtraction into addition logic.

### Tri-State Buffers
Tri-state buffers are essential for managing shared resources like data buses.
- **Three States:** 0, 1, and Z (High Impedance/Floating).
- **Function:** They allow multiple outputs to connect to the same wire, provided only one is "enabled" at a time, preventing electrical conflicts.
- **Usage:** Used to build larger structures like 2-to-1 and 4-to-1 multiplexers.

### Logic Simplification
- **Uniting Theorem:** The Boolean algebraic rule ($A \cdot B + A \cdot \overline{B} = A$) used to reduce complexity.
- **Automation:** Introduction to how modern CAD tools automate the minimization of circuits to save space and power.

---

## Part 2: Sequential Logic & Memory 

### Storage Elements
The transition to sequential logic introduces the concept of **State**.
- **Cross-Coupled Inverters:** The most basic form of memory, using feedback to hold a value.
- **Gated D-Latch:** A stable storage element created using NAND gates. 
    - **WE (Write Enable):** Controls when the data is stored.
    - **Metastability:** The lecture discusses avoiding unstable states during transitions.

### Registers and Memory Arrays
- **Registers:** Formed by grouping multiple D-latches in parallel to store multi-bit words (e.g., an 8-bit or 32-bit register).
- **Memory Arrays:** Scaled-up storage structures.
    - **Address Decoder:** Selects a specific row based on an input address.
    - **Storage Matrix:** The grid of latches.
    - **Column Circuitry:** Uses multiplexers to read the specific data from the selected row.

### Finite State Machines (FSM)
FSMs represent systems where the output depends on both the current input and the current state.
- **Model:** A discrete-time model used for control logic.
- **Example:** A combination lock that requires a specific sequence of inputs to change state from "Locked" to "Unlocked."

### Synchronous Design
- **Global Clock:** The heartbeat of the digital system.
- **Edge-Triggering:** State updates typically occur on the **rising edge** of the clock, ensuring all components synchronize their transitions and preventing logic races.

