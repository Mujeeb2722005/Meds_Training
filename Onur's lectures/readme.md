# Onur's Lecture Series: Digital Design & Computer Architecture

Welcome to the lecture log documentation subdirectory. This folder contains comprehensive Markdown write-ups, theoretical breakdowns, and architectural notes compiled directly from the deep-dive lectures on **Digital Design and Computer Architecture**.

---

## Module Overview

This series serves as the theoretical and practical backbone of the training track. It bridges the gap between hardware description syntax and physical microarchitecture, tracking everything from foundational combinational logic up to advanced modern processor execution paradigms.

---

## Lecture Roadmap

Below is the directory tracking the 6 core sessions covered during this training module. Click on any specific file to view detailed implementation notes, diagrams, and code snippets:

| Lecture File | Focus Core Topics | Key Architectural Milestones |
| :--- | :--- | :--- |
| **[Lecture 01](./lec1.md)** | Introduction & Hardware Eras | Evolution of computing, manufacturing boundaries, and abstract design stacks. |
| **[Lecture 02](./lec2.md)** | Combinational Circuits | Boolean algebra optimization, logic gate modeling, multiplexers, and ALU design. |
| **[Lecture 03](./lec3.md)** | Sequential Logic | Latches, flip-flops, finite state machines (FSMs), registers, and clock synchronization. |
| **[Lecture 04](./lec4.md)** | ISAs & Machine Language | Instruction Set Architectures (RISC vs. CISC), hardware-software interfacing, and memory addressing. |
| **[Lecture 05](./lec5.md)** | Single-Cycle Processors | Datapath construction, control units, execution state flows, and instruction decoding. |
| **[Lecture 06](./lec6.md)** | Pipelining & Performance | Hazard detection/forwarding, structural stalls, throughput calculations, and clock cycles per instruction ($CPI$). |

---

## Associated Engineering Tools

The practical verification and design files mapping to these theoretical concepts are built out using the workflows documented in the main workspace directory:
* **SystemVerilog / Verilog** for microarchitectural logic expression.
* **Verilator** for compiling HDL modules into highly optimized local C++ execution testbenches.
* **GTKwave** for analyzing timing paths, transition delays, and checking state machine registers.

---
*“Understanding hardware is the key to writing truly optimized software.”*