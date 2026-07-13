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