.data
 Aaddr: .word 0,2,1,4,5
 len: .word 5
.text
.globl main
main: 
 la $t0, Aaddr # $t0 = wskaznik na tablicê A
 lw $t1, len # $t1 = rozmiar tablicy A
 sll $t1, $t1, 2 # $t1 = 4*rozmiar
 add $t1, $t1, $t0 # $t1 = za ostatnim elementem A
Loop: lw $t2, 0($t0) # $t2 = A[i]
 addi $t2, $t2, 5 # $t2 = $t2 + 5
 sw $t2, 0($t0) # A[i] = $t2
 addi $t0, $t0, 4 # i = i+1
 bne $t0, $t1, Loop # if $t0<$t1 goto loop
 li $v0, 10 # exit
 syscall
