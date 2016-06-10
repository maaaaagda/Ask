.data
	wprowadzW: .asciiz "Wprowadz ilosc wierszy \n>"
	wprowadzK: .asciiz "Wprowadz ilosc kolumn \n>"
	wprowadzE: .asciiz "Wprowadz element "
	prompter: .asciiz ": "
	separatorK: .asciiz ", "
	separatorW: .asciiz "\n"
	wyswietlenie: .asciiz "Wczytana macierz: \n"
	end: .asciiz "Aby zakonczyc program, nacisnij 0 \n>"
.align 2
	tab: .space 4096
.text
main:
	jal czytajTab
	jal wypiszTab
	
	li $v0, 4
	la $a0, end
	syscall
	
	li $v0, 5
	syscall
	
	bnez $v0, main
	
	li $v0, 10
	syscall
czytajTab:
	la $s0, tab
	
	li $v0, 4
	la $a0, wprowadzW
	syscall
	
	li $v0, 5
	syscall
	move $s1, $v0
	
	li $v0, 4
	la $a0, wprowadzK
	syscall
	
	li $v0, 5
	syscall
	move $s2, $v0
	
	mul $s3, $s1, $s2
	mul $s3, $s3, 4
	
	move $t0, $zero
czytajLoop:
	beq $t0, $s3, koniecCzytania
	
	li $v0, 4
	la $a0, wprowadzE
	syscall
	
	div $t3, $t0, 4
	div $t1, $t3, $s2
	
	move $a0, $t1
	
	addi $a0, $a0, 1
	
	li $v0, 1
	syscall
	
	mul $t2, $s2, $t1
	sub $t2, $t3, $t2
	
	li $v0, 4
	la $a0, separatorK
	syscall
	
	move $a0, $t2
	addi $a0, $a0, 1
	
	li $v0, 1
	syscall
	
	li $v0, 4
	la $a0, prompter
	syscall
	
	li $v0, 5
	syscall
	
	add $t3, $s0, $t0
	sw $v0, ($t3)
	
	addi $t0, $t0, 4
	j czytajLoop
	
koniecCzytania:
	jr $ra
	
wypiszTab:
	move $t0, $zero
	
	li $v0, 4
	la $a0, wyswietlenie
	syscall
wypiszLoop:
	beq $t0, $s3, koniecPisania
	
	div $t3, $t0, 4
	div $t1, $t3, $s2
	
	add $t3, $s0, $t0
	lw $a0, ($t3)
	
	li $v0, 1
	syscall
	
	addi $t0, $t0, 4
	
	div $t3, $t0, 4
	div $t3, $t3, $s2
	
	mul $t4, $t3, $s2
	mul $t4, $t4, 4
	
	beq $t4, $t0, koniecKol
	
	li $v0, 4
	la $a0, separatorK
	syscall
	
	j wypiszLoop
koniecKol:
	li $v0, 4
	la $a0, separatorW
	syscall
	
	j wypiszLoop
koniecPisania:
	jr $ra
