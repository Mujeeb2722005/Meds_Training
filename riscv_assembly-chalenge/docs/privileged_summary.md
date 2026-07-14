# RISC-V Privileged Architecture Summary

**Course:** MEDS Lab Summer Training Programme 2026 (Cohort 4)   
**Module:** 3 - RISC-V Instruction Set Architecture   
**Task:** Self-Study Deliverable - Privileged Spec (Sections 3.1-3.4)   

---

## 1. Privilege Levels (The Chain of Command)

RISC-V processors use different privilege levels to keep the system secure and prevent normal apps from crashing the hardware. Think of it like a company's hierarchy:

* **Machine Mode (M-mode):** The highest level of privilege. This is the "Boss" mode. It is the only mode that *must* exist on every RISC-V chip. The deepest hardware code (firmware/bootloader) runs here, with total access to everything.
* **Supervisor Mode (S-mode):** The middle management. This is where the Operating System (like Linux or Windows) runs. It manages memory and keeps different programs from stepping on each other's toes. It is optional on simpler chips.
* **User Mode (U-mode):** The lowest privilege level. This is where everyday applications run. It has restricted access and cannot directly mess with the hardware or memory of other apps.

---

## 2. Key Control and Status Registers (CSRs)

Normal registers (like `x0` to `x31`) hold math data. **CSRs** are special registers that control how the processor behaves and keep track of its current status. 

Here are the 5 most important M-mode CSRs:

* **`mstatus` (Machine Status):** The master control panel. It keeps track of the current privilege level and controls whether global interrupts (hardware signals) are enabled or disabled.
* **`mtvec` (Machine Trap-Vector Base-Address):** The emergency contact number. It holds the memory address of the "Trap Handler" code. If something goes wrong, the processor immediately jumps to this address.
* **`mepc` (Machine Exception Program Counter):** The bookmark. When the processor is forced to jump to an emergency handler, it saves the address of the instruction it *was* working on right here, so it knows where to return later.
* **`mcause` (Machine Cause):** The error report. It stores a specific code that tells the trap handler *why* the interruption happened (e.g., an illegal instruction, a timer went off, or a system call).
* **`mtval` (Machine Trap Value):** The extra details. If the processor crashed because it tried to access bad memory, this register holds the exact bad memory address that caused the problem.

---

## 3. Trap Handling Flow (How Emergencies are Handled)

A "Trap" is the processor's word for an emergency pause. It can be an **Exception** (a software error, like dividing by zero) or an **Interrupt** (a hardware signal, like a mouse click). 

Here is the exact 4-step flow of what happens during a trap:

1.  **Detection:** The processor realizes a trap (exception or interrupt) has occurred. 
2.  **Hardware Reaction:** The processor automatically does three things without software help:
    * Saves the current instruction address into the `mepc` register.
    * Writes the reason for the trap into the `mcause` register.
    * Jumps to the emergency address stored in `mtvec`.
3.  **Software Action (The Handler):** The trap handler code takes over. It reads `mcause` to figure out what went wrong, fixes the problem (or terminates the crashing app), and prepares to go back to normal.
4.  **Return:** The handler executes a special instruction called `MRET` (Machine Return). The hardware looks at `mepc`, restores the old address into the Program Counter (PC), and normal execution resumes exactly where it left off.