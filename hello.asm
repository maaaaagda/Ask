.data

 MyMessage: .asciiz "Helloooo"
 
 #no musi byc no
 .text
 li $v0, 4
 la $a0, MyMessage
 syscall
 li $v0, 10
 syscall
 
