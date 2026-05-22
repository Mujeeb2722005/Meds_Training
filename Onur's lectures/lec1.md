# Lecture 1: Introduction – Fundamentals, Transistors, and Gates

**Course:** Digital Design and Computer Architecture (ETH Zürich)  
**Lecturer:** Prof. Onur Mutlu    

---

## 1. The Transformation Hierarchy
To build efficient computing systems, we must understand the layers of abstraction that translate a high-level problem into physical electron movement.

*   **Problem / Algorithm**
*   **System Software:** OS, Compilers.
*   **ISA (Instruction Set Architecture):** The hardware/software interface (e.g., x86, RISC-V).
*   **Microarchitecture:** Implementation of the ISA (pipelining, caching).
*   **Logic:** Digital gates and state elements.
*   **Devices:** Transistors (nMOS, pMOS).
*   **Physics:** Electrons and semiconductor properties.

> **Key Takeaway:** Modern efficiency comes from **Hardware/Software Co-design**, where we optimize across these layers simultaneously rather than in isolation.

---

## 2. The Transistor as a Switch
At the lowest level of digital logic, transistors function as electrically controlled switches.

### n-type MOS (nMOS)
*   **Symbol:** Standard gate.
*   **Behavior:** It is **ON** (closed circuit) when the Gate is **High (1)**.
*   **Pull-Down:** Typically used in the Pull-Down Network (PDN) to connect the output to Ground.

### p-type MOS (pMOS)
*   **Symbol:** Gate with a bubble (indicating inversion).
*   **Behavior:** It is **ON** (closed circuit) when the Gate is **Low (0)**.
*   **Pull-Up:** Typically used in the Pull-Up Network (PUN) to connect the output to $V_{DD}$.

---

## 3. CMOS Logic Gate Construction
Complementary Metal-Oxide-Semiconductor (CMOS) logic uses both nMOS and pMOS transistors to ensure that the output is always connected to either $V_{DD}$ (1) or Ground (0), never both.

### NOT Gate (Inverter)
*   **PUN:** 1 pMOS connected to $V_{DD}$.
*   **PDN:** 1 nMOS connected to Ground.
*   **Function:** $Y = \overline{A}$

### NAND Gate
*   **PUN (Parallel):** Two pMOS transistors in parallel. If **either** input is 0, the output is pulled to $V_{DD}$.
*   **PDN (Series):** Two nMOS transistors in series. **Both** inputs must be 1 to pull the output to Ground.
*   **Boolean Formula:** $Y = \overline{A \cdot B}$

### NOR Gate
*   **PUN (Series):** Two pMOS transistors in series. **Both** inputs must be 0 to pull the output to $V_{DD}$.
*   **PDN (Parallel):** Two nMOS transistors in parallel. If **either** input is 1, the output is pulled to Ground.
*   **Boolean Formula:** $Y = \overline{A + B}$

---

## 4. Processing Paradigms & Research
The course covers various architectures to solve the "Memory Wall" and "Power Wall":
*   **SIMD/GPUs:** Massive parallelism for data-heavy tasks.
*   **Systolic Arrays:** Highly efficient for matrix multiplications (e.g., Google TPU).
*   **Processing-in-Memory:** Moving computation closer to where data resides.

---