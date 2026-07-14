# RISC-V Extension Summary

**Course:** MEDS Lab Summer Training Programme 2026 (Cohort 4)   
**Module:** 3 - RISC-V Instruction Set Architecture   
**Task:** Self-Study Deliverable - Extension Summary   
**Topic:** The "C" (Compressed) Extension   

---

## 1. What It Adds (Overview)

* **The Problem:** Standard RISC-V instructions are always 32 bits long. This takes up a lot of memory.
* **The Solution:** The "C" Extension adds short, **16-bit versions** of the most commonly used instructions.
* **The Result:** Programs become about **25% smaller** in memory size.
* **How It Works:** It does not add new math or logic capabilities. Instead, the hardware acts like a ZIP file extractor—it takes the 16-bit instruction and instantly expands it back into a normal 32-bit instruction before running it.

---

## 2. Key Instructions

To fit an instruction into half the space (16 bits instead of 32 bits), the processor makes smart shortcuts. Compressed instructions start with a `c.` prefix. 

* **`c.addi` (Compressed Add Immediate):** * *Shortcut:* Assumes the destination register and the source register are the exact same. 
  * *Example:* Replaces `addi x5, x5, 1`
* **`c.lw` / `c.sw` (Compressed Load/Store Word):** * *Shortcut:* Only allows you to use the 8 most popular registers (`x8` through `x15`) and uses smaller memory offsets.
* **`c.beqz` / `c.bnez` (Compressed Branch if Zero / Not Zero):** * *Shortcut:* Checking if a number is zero is the most common test in programming. This instruction automatically assumes you are checking against the zero register (`x0`).
* **`c.jr` / `c.jalr` (Compressed Jump Register):** * *Shortcut:* Used heavily for returning from functions. It only needs the 5-bit register name to work.

---

## 3. Practical Applications (Why It Matters)

Making the code smaller has massive real-world benefits for hardware:

* **Cheaper Microchips (IoT & Embedded):** Smaller code means hardware engineers can use smaller, cheaper memory chips inside everyday devices like smartwatches, microwaves, or sensors.
* **Faster Performance:** Processors grab code from memory in chunks. If the instructions are smaller, the processor can grab more of them at once. This prevents the processor from waiting around for data, making the whole system faster.
* **Better Battery Life:** Fetching smaller instructions uses less memory bandwidth and less electricity, which is crucial for mobile phones and laptops.