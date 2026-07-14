# Grand Assignment: RISC-V Assembly

**Course:** MEDS Lab Summer Training Programme 2026 (Cohort 4)   
**Module:** 3 - RISC-V Instruction Set Architecture   

---

## Project Overview
This repository contains my final submission for the Module 3 Grand Assignment. It includes RISC-V assembly programs that demonstrate array processing, perfect adherence to the calling convention, recursive algorithms, and bitwise instruction decoding.

---

## Repository Structure

* **`part1_array_ops.s`**: Array processing program. Includes functions to find the sum, minimum, maximum, and count of negative numbers in an array.
* **`part2_recursion.s`**: Recursive implementation of the Tower of Hanoi algorithm. Fully implements the RISC-V stack frame and calling convention.
* **`part3_encoding.s`**: A mini instruction decoder. It uses bitwise shifts and masks to extract structural fields (opcode, rd, funct3, rs1) from hand-encoded hex instructions.
* **`docs/`**: 
  * `ENCODING_WORKSHEET.md`: Step-by-step manual encoding of 6 RISC-V instructions.
  * `PRIVILEGED_SUMMARY.md`: Self-study summary of RISC-V privilege levels and trap handling.
  * `EXTENSION_SUMMARY.md`: Self-study summary of the "C" (Compressed) Extension.
* **`screenshots/`**: Contains images of the Venus simulator console proving that each program runs correctly.

---

## How to Run the Code

All `.s` files in this project are designed to run in the web-based Venus simulator.

1. Open the [Venus Simulator](https://venus.cs61c.org/) in your web browser.
2. Open the file you want to run (e.g., `part1_array_ops.s`) and copy all the code.
3. Paste the code into the **Editor** tab in Venus.
4. Click over to the **Simulator** tab. This will assemble the code.
5. Click the **Run** button. The final results will be printed in the console window at the bottom of the screen.