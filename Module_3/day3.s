# task 1
.data
posit: .string "positive"
negat: .string "negative"
zeros: .string "zero"

.text 
.globl main 
main: 
   
    addi a0, zero, 5    
    ecall
    mv t0, a0          
    
   
    blt t0, zero, nega  # If < 0, go to nega
    bgt t0, zero, post  # If > 0, go to post
    beq t0, zero, zer   # If == 0, go to zer

post:
    la a1, posit       
    addi a0, zero, 4    
    ecall
    j exit              
nega:
    la a1, negat       
    addi a0, zero, 4
    ecall
    j exit            
zer:
    la a1, zeros        
    addi a0, zero, 4
    ecall
   
    
exit:
    addi a0, zero, 10  
    ecall


# task 2


.data 
nonnegative: .string "the factoral is always of non-negative values"

.text 
.globl main 
main: 
    #addi a0,zero, 5
    #ecall
    addi t0,zero,0    #reg stored value
    li t1, 1            #factorial val
    li t2, 1             # icounter
    li t3,1             #comapre val
    blt t0,zero,notneg
    beq t0,zero,fact1and0
    beq t0,t3,fact1and0
    bgt t0,t3, loopfac
    
    fact1and0:
        j end
    notneg:
        la a1,nonnegative
        addi a0, zero, 4
        ecall
        j end
    loopfac:
        bgt t2,t0, end
        mul t1,t1,t2
        addi t2,t2,1
        j loopfac   
     end:
       
       addi a0,zero,1
       mv a1,t1
       ecall

       addi a0, zero, 10  
        ecall



# task 3
.data

my_array:   .word 11, 22, 33, 44, 55, 66
array_len:  .word 6
msg_orig:   .string "Reversing array in-place...\n"
msg_space:  .string " "
msg_nl:     .string "\n"

.text
.globl main

main:

    la a0, msg_orig
    li a7, 4
    ecall

 
    la t0, my_array     # t0 = 'Left' pointer (starts at index 0)
    
    lw t1, array_len    # Load array length (6)
    slli t1, t1, 2      # Multiply length by 4 (6 * 4 = 24 bytes total offset)
    la t2, my_array     
    add t2, t2, t1      
    addi t2, t2, -4     # t2 = 'Right' pointer (points to the last element)

 
reverse_loop:
  
    bge t0, t2, print_setup

    lw t3, 0(t0)        # t3 = Value at Left pointer
    lw t4, 0(t2)        # t4 = Value at Right pointer


    sw t4, 0(t0)        # Write Right's value to Left's address
    sw t3, 0(t2)        # Write Left's value to Right's address


    addi t0, t0, 4      # Move Left pointer forward by 1 word (4 bytes)
    addi t2, t2, -4     # Move Right pointer backward by 1 word (4 bytes)

    j reverse_loop      # Repeat the loop

 
print_setup:
    la t0, my_array     # Reset t0 to the start of the array
    lw t1, array_len    # Reset t1 as the loop counter for printing

print_loop:
    beq t1, zero, exit  # If counter is 0, exit program

   
    lw a0, 0(t0)
    li a7, 1            # ecall 1 to print integer
    ecall


    la a0, msg_space
    li a7, 4
    ecall

    addi t0, t0, 4      # Advance pointer by 4 bytes
    addi t1, t1, -1     # Decrement counter
    j print_loop

exit:
    la a0, msg_nl
    li a7, 4
    ecall

    li a7, 10           # ecall 10 to exit cleanly
    ecall


# task 4

.data
my_array:   .word 10, 23, 35, 47, 50, 68, 72, 99
array_len:  .word 8
target:     .word 68    

msg_found:  .string "Target found at index: "
msg_not:    .string "Target not found: -1\n"
msg_nl:     .string "\n"

.text
.globl main

main:
   
    li t0, 0            # t0 = low index (0)
    lw t1, array_len    
    addi t1, t1, -1     # t1 = high index (length - 1 = 7)
    lw t2, target       # t2 = target value to search for
    la t3, my_array     # t3 = base address of the array

   
search_loop:

    bgt t0, t1, not_found

    add t4, t0, t1      # t4 = low + high
    srli t4, t4, 1      # t4 = (low + high) >> 1  (division by 2)

    slli t5, t4, 2      # t5 = mid * 4 (byte offset)
    add t6, t3, t5      # t6 = base address + offset
    lw s0, 0(t6)        # s0 = my_array[mid]

    beq s0, t2, found   # If my_array[mid] == target, jump to found
    blt s0, t2, go_high # If my_array[mid] < target, search the right half
    
 
    addi t1, t4, -1     # high = mid - 1
    j search_loop

go_high:
    addi t0, t4, 1      # low = mid + 1
    j search_loop

found:
    # Print success message
    la a0, msg_found
    li a7, 4
    ecall

    # Print the index (stored in t4)
    mv a0, t4
    li a7, 1
    ecall
    j exit

not_found:
    # Print -1 message
    la a0, msg_not
    li a7, 4
    ecall

exit:
    la a0, msg_nl
    li a7, 4
    ecall

    # Clean exit
    li a7, 10
    ecall

# task 6
.data

my_array:   .word 64, 34, 25, 12, 22, 11
array_len:  .word 6

msg_title:  .string "Sorting array using Bubble Sort...\n"
msg_space:  .string " "
msg_nl:     .string "\n"

.text
.globl main

main:
  
    la a0, msg_title
    li a7, 4
    ecall

   
    lw t0, array_len    # t0 = n (Array length = 6)
    la t1, my_array     # t1 = Base address of the array


    li t2, 0            # t2 = i (Outer loop index)

outer_loop:
   
    addi t4, t0, -1     # t4 = n - 1
    bge t2, t4, print_setup

    li t3, 0            # t3 = j (Inner loop index)
    sub t5, t4, t2      # t5 = n - i - 1 (Limit for the inner loop)

inner_loop:
    
    bge t3, t5, advance_outer

  
    slli t6, t3, 2      # t6 = j * 4 (Byte offset for j)
    add  s0, t1, t6     # s0 = Address of my_array[j]
    addi s1, s0, 4      # s1 = Address of my_array[j+1]


    lw a1, 0(s0)        # a1 = my_array[j]
    lw a2, 0(s1)        # a2 = my_array[j+1]

   
    ble a1, a2, advance_inner

    
    sw a2, 0(s0)
    sw a1, 0(s1)

advance_inner:
    addi t3, t3, 1      # j++
    j inner_loop

advance_outer:
    addi t2, t2, 1      # i++
    j outer_loop

print_setup:
    la t0, my_array     # Reset pointer to start of the array
    lw t1, array_len    # Reset counter to loop through array elements

print_loop:
    beq t1, zero, exit  # If all elements printed, exit

    lw a0, 0(t0)
    li a7, 1            # ecall 1 to print integer
    ecall


    la a0, msg_space
    li a7, 4
    ecall

    addi t0, t0, 4      # Advance pointer by 4 bytes
    addi t1, t1, -1     # Decrement loop counter
    j print_loop


exit:
    la a0, msg_nl
    li a7, 4
    ecall

    li a7, 10           # Exit program
    ecall