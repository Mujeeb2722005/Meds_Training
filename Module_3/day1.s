/*Task 1:  Write a Venus program that loads 42 into a0 and 58 into a1,
 adds them,  and prints the result (100) using ecall 1. Step through every instruction.*/

 .text 
.globl main 
main: 
    addi a0,zero, 42
    addi a1,zero,58
    add a1,a1,a0
    addi a0,zero,1
    ecall
    addi a0, zero, 10  
    ecall


/*Task 2: Write a program that reads two integers from user (ecall 5), adds them, 
and prints the sum..*/

.text 
.globl main 
main: 
    addi a7,zero, 5
    ecall
    mv t0,a0
    addi a7,zero,5
    ecall
    mv t1,a0
    add a0,t0,t1
    addi a7,zero,1
    ecall
    addi a7, zero, 10  
    ecall



/*Task 3:  Write a program that prints "Hello MEDS!" using a .data string and ecall */
.data 
hello: .string "HElLLO MEDS"
.text 
.globl main 
main: 
    la a1,hello
    addi a0,zero,4
    ecall
    
    addi a0,zero,10
    ecall
     

/*Task 4: Explore all 32 registers: write a unique value to every register (except 
x0). Confirm x0 always reads 0.  */

.text 
.globl main 
main: 
    addi x0, x0, 99
    add x1, x0, x0
    li x1, 1      # ra (return address)
    li x2, 2      # sp (stack pointer)
    li x3, 3      # gp (global pointer)
    li x4, 4      # tp (thread pointer)
    li x5, 5      # t0 (temporary register 0)
    li x6, 6      # t1
    li x7, 7      # t2
    li x8, 8      # s0 / fp (saved register 0 / frame pointer)
    li x9, 9      # s1
    li x10, 10    # a0 (function argument / return value 0)
    li x11, 11    # a1 (function argument / return value 1)
    li x12, 12    # a2
    li x13, 13    # a3
    li x14, 14    # a4
    li x15, 15    # a5
    li x16, 16    # a6
    li x17, 17    # a7 (environment call number)
    li x18, 18    # s2 (saved register 2)
    li x19, 19    # s3
    li x20, 20    # s4
    li x21, 21    # s5
    li x22, 22    # s6
    li x23, 23    # s7
    li x24, 24    # s8
    li x25, 25    # s9
    li x26, 26    # s10
    li x27, 27    # s11
    li x28, 28    # t3 (temporary register 3)
    li x29, 29    # t4
    li x30, 30    # t5
    li x31, 31    # t6
    
    li a7, 10     # Load environment call number 10 (exit) into a7 (x17)
    ecall


/*Task 5:  Write a program that computes 1+2+3+...+N for a user-provided N using 
a loop. Print the result.   */

.text 
.globl main 
main: 

    addi a7,zero, 5
    ecall
    mv t0,a0             #input value stored in it
    
    li t1, 0              #counter
    li t2,0                # sum variable
    
    loop:
    	bgt t1,t0,done
    	add t2,t2,t1
    	addi t1,t1,1
    	j loop
    	
    done:
    	addi a7,zero,1
    	mv a0,t2
    	ecall
    
    	addi a7, zero, 10  
    	ecall



# task 6: bounus task even and odd

.data
eve: .string "even"
od: .string "odd"
.text 
.globl main 
main: 

    addi a7,zero, 5
    ecall
    mv t0,a0             #input value stored in it
    andi t1,t0,1
    
    beq t1,zero,even
    bne t1,zero,odd
    odd:
    	la a0,od
    	addi a7,zero,4
    	ecall
    	j end
    
    even:
    	la a0,eve
    	addi a7,zero,4
    	ecall
    	j end
    	
    end:
    	addi a7,zero,10
    	ecall	
   