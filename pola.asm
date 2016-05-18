.data
	co: .asciiz "\n*******************Wybierz: ******************* \n1 - objetosc kuli \n2 - pole kuli \n3 - objetosc szescianu \n4 - pole szescianu \n5 - zakoncz \n6 - wprowadz dane\n"
	wprowadz: .asciiz "Podaj promien/krawedz: "
	szescianPole: .asciiz "Pole szescianu: "
	szescianObj: .asciiz" Objetosc szescianu: "
	kulaPole: .asciiz"Pole kuli: "
	kulaObj:.asciiz "Objetosc kuli: "
	wybrano: .asciiz "Wybrales: "
	
	
.text
 menu:
 		
 	#wprowadz wybor
 	li $v0, 4
 	la $a0, co
 	syscall
	
		
 	#wprowadz wybor
 	li $v0, 4
 	la $a0, wybrano
 	syscall
 	 	 	
 	#wprowadz x
 	li $v0, 5
 	syscall
 	move $t0, $v0
 	
 	#wybor
 	beq $v0, 1, KulaObj
 	beq $v0, 2, KulaPole
 	beq $v0, 3, SzescianObj
 	beq $v0, 4, SzescianPole
 	beq $v0, 5, koniec
 	beq $v0, 6, wprowadzDane
 
KulaObj:
	jal funkcjaKulaObj
	j menu
KulaPole:
	jal funkcjaKulaPole
	j menu
SzescianObj:
	jal funkcjaSzescianObj
	j menu
SzescianPole:
	jal funkcjaSzescianPole
	j menu	
koniec:
	#Zakoñczenie programu
	li $v0, 10
	syscall
	
 	
 wprowadzDane:
 	#wprowadz info o x
 	li $v0, 4
 	la $a0, wprowadz
 	syscall
 	
 	#wprowadz x
 	li $v0, 5
 	syscall
 	move $t1, $v0
 	j menu
 	
funkcjaSzescianPole: 	

 	
 	#pole
 	mul $t2, $t1, $t1
	mul $t2, $t2, $t1 
	mul $t2, $t2, 6
	
	#wprowadz info o wyniku
 	li $v0, 4
 	la $a0, szescianPole
 	syscall
 	
 	#wydrukuj wynik
 	li $v0, 1
 	move $a0, $t2
 	syscall
 	jr $ra
 	
funkcjaSzescianObj: 	

 	
 	#pole
 	mul $t2, $t1, $t1
	mul $t2, $t2, $t1 
	
	
	#wprowadz info o wyniku
 	li $v0, 4
 	la $a0, szescianObj
 	syscall
 	
 	#wydrukuj wynik
 	li $v0, 1
 	move $a0, $t2
 	syscall
 	jr $ra
 
funkcjaKulaPole: 	

 	
 	#pole
 	mul $t2, $t1, $t1
	mul $t2, $t2, 12
	
	#wprowadz info o wyniku
 	li $v0, 4
 	la $a0, kulaPole
 	syscall
 	
 	#wydrukuj wynik
 	li $v0, 1
 	move $a0, $t2
 	syscall
 	jr $ra
 	
funkcjaKulaObj: 	

 	#pole
 	mul $t2, $t1, $t1
	mul $t2, $t2, $t1
	mul $t2, $t2, 4 
	
	
	#wprowadz info o wyniku
 	li $v0, 4
 	la $a0, kulaObj
 	syscall
 	
 	#wydrukuj wynik
 	li $v0, 1
 	move $a0, $t2
 	syscall
	jr $ra
