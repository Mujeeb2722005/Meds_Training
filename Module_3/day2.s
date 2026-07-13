# task 1
.text 
.globl main 
main: 
   addi t0, zero, 12
   addi t1 , zero, 64
   slli t0,t0, 3
   srli t1, t1,2
   sub t2,t0,t1
   addi a0,zero, 1
   mv a1,t2
   ecall

    addi a0, zero, 10  
    ecall



/*task2: Write a program that extracts the lower byte, second byte, and upper 
half-word from 0xDEADBEEF using AND/shift. Print each. */

.data
msg_lower:  .string "Lower byte: 0x"
msg_second: .string "\nSecond byte: 0x"
msg_upper:  .string "\nUpper half-word: 0x"
newline:    .string "\n"

.text
.globl main

main:
    li t0, 0xDEADBEEF
    
    andi t1, t0, 0xFF     #lower byte

    la a0, msg_lower
    addi a7, zero, 4
    ecall
    mv a0, t1
    addi a7, zero, 34     # ecall 34 prints in Hex
    ecall

    srli t2, t0, 8       #seconf byte
    andi t2, t2, 0xFF

    la a0, msg_second
    addi a7, zero, 4
    ecall
    mv a0, t2
    addi a7, zero, 34
    ecall

    srli t3, t0, 16     #uper half word
    
 
    la a0, msg_upper
    addi a7, zero, 4
    ecall
 
    mv a0, t3
    addi a7, zero, 34
    ecall

    la a0, newline
    addi a7, zero, 4
    ecall

    addi a7, zero, 10
    ecall
   


# task 4
.data
my_array: .word 10,20,-29,40,50

.text 
.globl main 
main: 
    la s0,my_array
    li s1,5
    li t0, 0
    lw s2, 0(s0)
    loop:
        bge t0,s1,done
        slli t1,t0,2
        add t2,s0,t1
        lw t3,0(t2)
        ble t3,s2,skip
           
    max:
        mv s2,t3
    skip:
        addi t0,t0,1
        j loop 
    done:
        addi a0,zero,1
         mv a1,s2
        ecall
    
        addi a0, zero, 10  
        ecall
    
   
   