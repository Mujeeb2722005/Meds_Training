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
   