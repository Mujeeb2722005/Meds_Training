# Lecture 5: Verilog II, HDL Fundamentals, and Timing

**Lecturer:** Prof. Onur Mutlu  
**Focus:** Advanced Verilog syntax, hierarchical design, FSM implementation, and the fundamentals of circuit timing.

---

## 1. Design Methodology 

Prof. Mutlu emphasizes a dual-approach to robust hardware design:
* **Top-Down Design:** Breaking a complex system into smaller, manageable hierarchical modules.
* **Bottom-Up Implementation:** Designing and verifying "leaf cells" (the smallest modules) first. 
* **Verification:** The mantra of the lecture is to verify every module at its own level before integration to avoid "debug hell."

---

## 2. Verilog Syntax & Modeling 

### Modeling Styles
| Style | Description | Focus |
| :--- | :--- | :--- |
| **Structural** | Connecting gates and modules like a schematic. | Gate-level netlists. |
| **Behavioral** | Describing the functionality or "algorithm." | Logic equations and always blocks. |

### Bit Manipulation Operations
Verilog provides powerful tools for signal routing and formatting:
* **Slicing:** `wire [3:0] sub_bus = main_bus[7:4];`
* **Concatenation:** `{a, b}` combines two signals into one bus.
* **Duplication:** `{4{1'b0}}` creates `4'b0000`.

### Behavioral Modeling with `assign`
Combinational logic is typically described using the `assign` keyword (Continuous Assignment).
* Example: `assign out = (a & b) | c;`

---

## 3. Parametrization & Reusability 

To increase code reusability, Verilog allows modules to be **parameterized**. This is essential for creating "N-bit" wide components (like an N-bit adder) without rewriting code for every specific width.
* **Keyword:** `parameter`
* **Instantiation:** `adder #(.WIDTH(16)) my_adder (...);`

---

## 4. Sequential Logic & FSMs 

### Always Blocks & Assignments
Sequential logic requires sensitivity lists to trigger updates on specific events (usually clock edges).

| Assignment Type | Symbol | Usage | Behavior |
| :--- | :--- | :--- | :--- |
| **Blocking** | `=` | Combinational logic | Executes sequentially (like software). |
| **Non-blocking** | `<=` | Sequential logic | All assignments happen concurrently at the clock edge. |

### Finite State Machines (FSM)
The lecture implements FSMs by separating logic into three parts:
1.  **State Register:** Sequential `always @(posedge clk)` block.
2.  **Next-State Logic:** Combinational block determining the transition.
3.  **Output Logic:** Determining the output based on State (Moore) or State + Input (Mealy).
* **Example Case:** The "Smiling Snail" sequence detector.

---

## 5. Circuit Timing (Lecture 5b Intro) 

### Combinational Timing
Real-world gates are not instantaneous.
* **Propagation Delay ($t_{pd}$):** The maximum time from input change to the output reaching its final value.
* **Contamination Delay ($t_{cd}$):** The minimum time from input change to the output beginning to change.

### Sequential Timing Constraints
To ensure data is captured correctly by a flip-flop, two constraints must be met:
1.  **Setup Time ($t_{setup}$):** Data must be stable *before* the clock edge.
2.  **Hold Time ($t_{hold}$):** Data must remain stable for a short period *after* the clock edge.

### Design Trade-offs
Digital design is a constant balancing act between three pillars:
* **Area:** Physical size/gate count.
* **Speed:** Maximum clock frequency (impacted by $t_{pd}$).
* **Power:** Energy consumption (impacted by switching frequency).

---
*Reference: Digital Design and Computer Architecture - Prof. Onur Mutlu.*
