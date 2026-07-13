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
   
# task 3

.data

my_array: .word 10, 20, 30, 40, 50, 60, 70, 80
msg:      .string "The sum of the array is: "

.text
.globl main

main:

    li t0, 8            # t0 = Loop counter (we have 8 elements)
    li t1, 0            # t1 = Running sum (start at 0)
    la t2, my_array     # t2 = Base address (pointer to the start of the array)

loop:
    lw t3, 0(t2)        # Load the current word from memory at address t2 into t3
    add t1, t1, t3      # Add the loaded value (t3) to our running sum (t1)

    addi t2, t2, 4      # Move the memory pointer forward by 4 bytes to the next word
    addi t0, t0, -1     # Decrement our loop counter by 1

    bne t0, zero, loop  # If the counter is not zero, jump back to 'loop'

   
    la a0, msg
    li a7, 4            # ecall 4 is print string
    ecall


    mv a0, t1           # Move the final sum from t1 into a0
    li a7, 1            # ecall 1 is print integer
    ecall

    li a7, 10
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
    
   
# task 5

.data

magic_num: .word 0xDEADBEEF


msg_w:  .string "Loaded as Word:      0x"
msg_h0: .string "\nHalf-word (offset 0): 0x"
msg_h2: .string "\nHalf-word (offset 2): 0x"
msg_b0: .string "\nByte (offset 0):      0x"
msg_nl: .string "\n"

.text
.globl main

main:
  
    la t0, magic_num

    lw t1, 0(t0)        # Loads all 4 bytes

    la a0, msg_w
    li a7, 4
    ecall
    mv a0, t1
    li a7, 34           # Print in Hex
    ecall


    lhu t2, 0(t0)       # Loads 2 bytes from offset 0
                        # Uses 'lhu' (unsigned) to prevent sign extension

    la a0, msg_h0
    li a7, 4
    ecall
    mv a0, t2
    li a7, 34
    ecall

  
    lhu t3, 2(t0)       # Loads 2 bytes skipping the first 2 bytes

    la a0, msg_h2
    li a7, 4
    ecall
    mv a0, t3
    li a7, 34
    ecall


    lbu t4, 0(t0)       # Loads the single lowest byte from memory

    la a0, msg_b0
    li a7, 4
    ecall
    mv a0, t4
    li a7, 34
    ecall

    la a0, msg_nl
    li a7, 4
    ecall

    li a7, 10
    ecall
