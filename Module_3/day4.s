# task 1
.data
my_array:   .word 5, 10, 15, 20, 25
array_size: .word 5
msg_max:    .string "Max of 42 and 17 is: "
msg_sum:    .string "\nSum of array is: "

.text
.globl main

main:
  
    li a0, 42
    li a1, 17
    jal ra, max          # Call max(42, 17)
    
  
    mv t0, a0            # Save result temporarily
    la a0, msg_max
    li a7, 4
    ecall
    mv a0, t0
    li a7, 1
    ecall

   
    la a0, my_array
    lw a1, array_size
    jal ra, sum_array    # Call sum_array
    
   
    mv t0, a0
    la a0, msg_sum
    li a7, 4
    ecall
    mv a0, t0
    li a7, 1
    ecall

    # Exit
    li a7, 10
    ecall


max:
    bge a0, a1, max_done # If a0 >= a1, it's already in a0
    mv a0, a1            # Otherwise, move a1 into a0
max_done:
    ret                  # Return to caller


sum_array:
    li t0, 0             # Running sum = 0
sum_loop:
    beq a1, zero, sum_done # If size == 0, exit loop
    lw t1, 0(a0)         # Load current element
    add t0, t0, t1       # Add to running sum
    addi a0, a0, 4       # Advance pointer by 4 bytes (1 word)
    addi a1, a1, -1      # Decrement size
    j sum_loop
sum_done:
    mv a0, t0            # Move final sum to a0 for return
    ret

# task2 

.data
msg_fib: .string "fib(10) = "

.text
.globl main

main:
    la a0, msg_fib
    li a7, 4
    ecall

    li a0, 10           # Calculate fib(10)
    jal ra, fib
    
    li a7, 1            # Print the result (should be 55)
    ecall

    li a7, 10           # Exit
    ecall


fib:
  
    li t0, 1
    ble a0, t0, fib_base 

   
    addi sp, sp, -12
    sw ra, 8(sp)        # Save return address
    sw s0, 4(sp)        # Save s0 (will hold n)
    sw s1, 0(sp)        # Save s1 (will hold fib(n-1))

    mv s0, a0           # s0 = n

    
    addi a0, s0, -1
    jal ra, fib
    mv s1, a0           # s1 = fib(n-1)

   
    addi a0, s0, -2
    jal ra, fib         # a0 = fib(n-2)

    
    add a0, a0, s1      # a0 = fib(n-1) + fib(n-2)

   
    lw ra, 8(sp)
    lw s0, 4(sp)
    lw s1, 0(sp)
    addi sp, sp, 12
    ret

fib_base:
    ret                 # a0 already holds 0 or 1, simply return


# task 3

.text
.globl main

main:
   
    li s1, 999          
    
   
    jal ra, funcA       

    # Exit
    li a7, 10
    ecall


funcA:
    
    addi sp, sp, -8
    sw ra, 4(sp)
    sw s1, 0(sp)

    li s1, 42           

   
    jal ra, funcB       

    lw s1, 0(sp)
    lw ra, 4(sp)
    addi sp, sp, 8
    ret                 # Return to main


funcB:
  
    li a0, 100          # Arbitrary work
    ret                 # Return to funcA


# task 6

.data
msg_pow: .string "2^10 = "

.text
.globl main

main:
    la a0, msg_pow
    li a7, 4
    ecall

    li a0, 2            # Base = 2
    li a1, 10           # Exponent = 10
    jal ra, power
    
    li a7, 1            # Print result (1024)
    ecall

    li a7, 10           # Exit
    ecall


power:
    
    bne a1, zero, pow_recurse
    li a0, 1
    ret

pow_recurse:

    addi sp, sp, -8
    sw ra, 4(sp)
    sw s0, 0(sp)

    mv s0, a0           # Save the base (a0) into s0

  
    addi a1, a1, -1
    jal ra, power       # Result comes back in a0

  
    mul a0, a0, s0      # a0 = power(base, exp-1) * base

  
    lw ra, 4(sp)
    lw s0, 0(sp)
    addi sp, sp, 8
    ret
