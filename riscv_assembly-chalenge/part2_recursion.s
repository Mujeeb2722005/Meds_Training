
.data
    .align 2
    str_test1: .string "\n--- Test Case 1: N = 2 ---\n"
    str_test2: .string "\n--- Test Case 2: N = 3 ---\n"
    str_test3: .string "\n--- Test Case 3: N = 4 ---\n"
    
    str_move1: .string "Move disk "
    str_move2: .string " from "
    str_move3: .string " to "
    str_nl:    .string "\n"

.text
.globl main
main:
    li a0, 4                # ecall 4: Print string
    la a1, str_test1
    ecall

    li a0, 2                # arg0: N = 2 disks
    li a1, 65               # arg1: Source Peg = 'A' (ASCII 65)
    li a2, 66               # arg2: Aux Peg = 'B' (ASCII 66)
    li a3, 67               # arg3: Dest Peg = 'C' (ASCII 67)
    call hanoi
    
    li a0, 4
    la a1, str_test2
    ecall

    li a0, 3                # arg0: N = 3 disks
    li a1, 65               # 'A'
    li a2, 66               # 'B'
    li a3, 67               # 'C'
    call hanoi
    
    li a0, 4
    la a1, str_test3
    ecall

    li a0, 4                # arg0: N = 4 disks
    li a1, 65               # 'A'
    li a2, 66               # 'B'
    li a3, 67               # 'C'
    call hanoi

  
    li a0, 10               # ecall 10: Exit program
    ecall


hanoi:
    # Base Case: if (n == 0) return;
    blez a0, hanoi_return

    addi sp, sp, -32
    sw ra, 28(sp)           # Save return address
    sw s0, 24(sp)           # Save s0 (will hold 'n')
    sw s1, 20(sp)           # Save s1 (will hold 'src')
    sw s2, 16(sp)           # Save s2 (will hold 'aux')
    sw s3, 12(sp)           # Save s3 (will hold 'dst')

   
    mv s0, a0               # s0 = n
    mv s1, a1               # s1 = src
    mv s2, a2               # s2 = aux
    mv s3, a3               # s3 = dst

  #Recursive call:1
    addi a0, s0, -1         # arg0: n - 1
    mv a1, s1               # arg1: src
    mv a2, s3               # arg2: dst (becomes the aux peg)
    mv a3, s2               # arg3: aux (becomes the dst peg)
    call hanoi

    li a0, 4
    la a1, str_move1
    ecall
    
    # Print: [n]
    li a0, 1
    mv a1, s0
    ecall

    # Print: " from "
    li a0, 4
    la a1, str_move2
    ecall

    # Print: [src]
    li a0, 11               # ecall 11: Print Char
    mv a1, s1
    ecall

    # Print: " to "
    li a0, 4
    la a1, str_move3
    ecall

    # Print: [dst]
    li a0, 11
    mv a1, s3
    ecall

    # Print: "\n"
    li a0, 4
    la a1, str_nl
    ecall

    #RECURSIVE CALL: hanoi
    addi a0, s0, -1         # arg0: n - 1
    mv a1, s2               # arg1: aux (becomes the src peg)
    mv a2, s1               # arg2: src (becomes the aux peg)
    mv a3, s3               # arg3: dst
    call hanoi


    lw ra, 28(sp)
    lw s0, 24(sp)
    lw s1, 20(sp)
    lw s2, 16(sp)
    lw s3, 12(sp)
    addi sp, sp, 32

hanoi_return:
    ret