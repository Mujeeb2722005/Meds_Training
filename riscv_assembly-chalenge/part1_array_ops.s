
.data
    .align 2
    my_array: .word 15, -7, 42, 89, -100, 0, 3, -12, 55, -1, 23, 77
    .equ SIZE, 12
    str_sum: .string "Sum: "
    str_min: .string "\nMin: "
    str_max: .string "\nMax: "
    str_neg: .string "\nNegative Count: "
    str_nl:  .string "\n"
.text
.globl main
main:
    # calculate sum
    li a0, 4                # ecall 4: Print String
    la a1, str_sum          # Load string address
    ecall
    
    la a0, my_array         # arg0: array pointer
    li a1, SIZE             # arg1: array size
    call sum_array          # Call function
    
    mv a1, a0               # Move result to a1 for printing
    li a0, 1                # ecall 1: Print Integer
    ecall

   # calculate min
    li a0, 4                # ecall 4: Print String
    la a1, str_min
    ecall
    
    la a0, my_array
    li a1, SIZE
    call find_min
    
    mv a1, a0
    li a0, 1                # ecall 1: Print Integer
    ecall

    # calculate max
    li a0, 4                # ecall 4: Print String
    la a1, str_max
    ecall
    
    la a0, my_array
    li a1, SIZE
    call find_max
    
    mv a1, a0
    li a0, 1                # ecall 1: Print Integer
    ecall

    # calculate negative count
    li a0, 4                # ecall 4: Print String
    la a1, str_neg
    ecall
    
    la a0, my_array
    li a1, SIZE
    call count_negative
    
    mv a1, a0
    li a0, 1                # ecall 1: Print Integer
    ecall

    
    li a0, 4
    la a1, str_nl
    ecall

   
    li a0, 10               # ecall 10: Exit program
    ecall
# ----functions---
sum_array:
    
    addi sp, sp, -16
    sw s0, 0(sp)            # s0 will hold the running sum
    sw s1, 4(sp)            # s1 will hold the loop index
    sw s2, 8(sp)            # s2 will hold the array pointer

    li s0, 0                # sum = 0
    li s1, 0                # i = 0
    mv s2, a0               # Save pointer to s2

sum_loop:
    bge s1, a1, sum_done    # if i >= size, exit loop
    slli t0, s1, 2          # t0 = i * 4 (byte offset)
    add t1, s2, t0          # t1 = base_address + offset
    lw t2, 0(t1)            # t2 = array[i]
    
    add s0, s0, t2          # sum += array[i]
    addi s1, s1, 1          # i++
    j sum_loop

sum_done:
    mv a0, s0               # Place result in return register

   
    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    addi sp, sp, 16
    ret

find_min:
    addi sp, sp, -16
    sw s0, 0(sp)            # s0 = min_val
    sw s1, 4(sp)            # s1 = index (i)
    sw s2, 8(sp)            # s2 = array pointer

    lw s0, 0(a0)            # Initialize min_val = array[0]
    li s1, 1                # Start loop at i = 1
    mv s2, a0               

min_loop:
    bge s1, a1, min_done    # if i >= size, exit loop
    slli t0, s1, 2          
    add t1, s2, t0          
    lw t2, 0(t1)            # t2 = array[i]
    
    bge t2, s0, min_skip    # if array[i] >= min_val, skip update
    mv s0, t2               # else min_val = array[i]
min_skip:
    addi s1, s1, 1          # i++
    j min_loop

min_done:
    mv a0, s0               # Return min_val

    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    addi sp, sp, 16
    ret

find_max:
    addi sp, sp, -16
    sw s0, 0(sp)            # s0 = max_val
    sw s1, 4(sp)            # s1 = index (i)
    sw s2, 8(sp)            # s2 = array pointer

    lw s0, 0(a0)            # Initialize max_val = array[0]
    li s1, 1                # Start loop at i = 1
    mv s2, a0               

max_loop:
    bge s1, a1, max_done    
    slli t0, s1, 2          
    add t1, s2, t0          
    lw t2, 0(t1)            # t2 = array[i]
    
    ble t2, s0, max_skip    # if array[i] <= max_val, skip update
    mv s0, t2               # else max_val = array[i]
max_skip:
    addi s1, s1, 1          
    j max_loop

max_done:
    mv a0, s0               # Return max_val

    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    addi sp, sp, 16
    ret

count_negative:
    addi sp, sp, -16
    sw s0, 0(sp)            # s0 = count
    sw s1, 4(sp)            # s1 = index (i)
    sw s2, 8(sp)            # s2 = array pointer

    li s0, 0                # count = 0
    li s1, 0                # i = 0
    mv s2, a0               

neg_loop:
    bge s1, a1, neg_done    
    slli t0, s1, 2          
    add t1, s2, t0          
    lw t2, 0(t1)            # t2 = array[i]
    
    bge t2, zero, neg_skip  # if array[i] >= 0, skip increment
    addi s0, s0, 1          # else count++
neg_skip:
    addi s1, s1, 1          
    j neg_loop

neg_done:
    mv a0, s0               # Return count

    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    addi sp, sp, 16
    ret