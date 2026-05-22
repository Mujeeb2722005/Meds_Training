# Lecture: Timing & Verification II

**Course:** Digital Design and Computer Architecture  
**Lecturer:** Prof. Onur Mutlu  
**Focus:** Physical realities of circuit design, timing constraints, and verification methodologies.

---

## 1. Combinational Circuit Timing 

Digital circuits are not ideal; transistors exhibit finite switching speeds governed by **RC delays** (Resistance and Capacitance).

### Delay Definitions
* **Propagation Delay ($t_{pd}$):** The maximum time from an input change until the output finishes changing and reaches a stable final value. This defines the **Longest (Critical) Path**.
* **Contamination Delay ($t_{cd}$):** The minimum time from an input change until the output starts changing. This defines the **Shortest Path**.

### Glitches (Static Hazards)
Glitches occur when an output changes transiently (e.g., $1 \to 0 \to 1$) due to different propagation speeds along multiple logic paths. While they do not affect functional correctness in synchronous systems (if the clock is slow enough), they consume extra power.

---

## 2. Sequential Circuit Timing 

To ensure a flip-flop reliably samples data at a clock edge, the input must be stable during a specific "sampling window."

### Setup and Hold Constraints
| Constraint | Description | Requirement |
| :--- | :--- | :--- |
| **Setup Time ($t_{setup}$)** | Time the data must be stable **before** the clock edge. | $T_c \geq t_{pcq} + t_{pd} + t_{setup}$ |
| **Hold Time ($t_{hold}$)** | Time the data must remain stable **after** the clock edge. | $t_{cd} + t_{ccq} > t_{hold}$ |

* **Metastability:** Violating these times can cause a flip-flop to enter an unstable state between 0 and 1, potentially causing system failure.
* **Clock Skew:** Occurs when the clock signal reaches different flip-flops at different times. This reduces the effective clock period and can cause hold time violations.

---

## 3. Circuit Verification 

Verification ensures the hardware correctly implements the intended logic.

### Functional Verification
* **Device Under Test (DUT):** The module being verified.
* **Test Benches:** Verilog/HDL code used to apply stimulus and check results.
* **Golden Model:** A trusted behavioral model (often in a high-level language or a simpler HDL version) used to compare against the DUT output for automated checking.

### Verification Levels
1.  **Logic Simulation:** Fast and efficient; checks for logical correctness using HDL simulators.
2.  **Circuit Simulation (SPICE):** Very slow; models transistors and wires with high physical accuracy.
3.  **Timing Verification:** Static timing analysis tools verify that the final physical implementation meets all $t_{setup}$ and $t_{hold}$ constraints.

---

## 4. Summary of Timing Parameters

| Symbol | Name | Definition |
| :--- | :--- | :--- |
| $T_c$ | Clock Period | The time between successive rising edges of the clock. |
| $t_{pcq}$ | Prop. delay (CLK to Q) | Max time from clock edge to stable output at Q. |
| $t_{ccq}$ | Cont. delay (CLK to Q) | Min time from clock edge to beginning of output change at Q. |
| $t_{pd}$ | Prop. delay (Logic) | Max delay through combinational logic. |
| $t_{cd}$ | Cont. delay (Logic) | Min delay through combinational logic. |

---
*Reference: Digital Design and Computer Architecture Series - Prof. Onur Mutlu.*
