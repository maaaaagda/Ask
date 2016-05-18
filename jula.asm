
.data
	text1: .asciiz "\n==========MENU=========="
	text2: .asciiz "\n1)Wprowadz zmienne x i y"
	text3: .asciiz "\n2)Wykonaj dzielenie x/y"
	text4: .asciiz "\n3)Wykonaj modulo x%y"
	text5: .asciiz "\n4)Wyjdz z programu"
	text6: .asciiz "\nWprowadz wybor:"
	textError: .asciiz "Bledne dane, sprobuj ponownie."
	text7: .asciiz "Wprowadz x = "
	text8: .asciiz "Wprowadz y = "
	text9: .asciiz "Wynik dzielenia x/y: "
	text10: .asciiz "Wynik modulo x%y = "
	text11: .asciiz "Nie wprowadzono danych!"
.text
	#£adujemy wartoœci do rejestrów
	li $t1, 1
	li $t2, 2
	li $t3, 3
	li $t4, 4
menu:
	#Tekst 'menu'
	li $v0, 4
	la $a0, text1
	syscall
	
	#Wyswietlenie opcji 1
	li $v0, 4
	la $a0, text2
	syscall

	#Wyœwietlenie opcji 2	
	li $v0, 4
	la $a0, text3
	syscall
	
	#Wyswietlenie opcji 3
	li $v0, 4
	la $a0, text4
	syscall
	
	#Wyœwietlenie opcji 4
	li $v0, 4
	la $a0, text5
	syscall
pobieranieDanych:
	#Wyœwietlenie zaproszenia do wprowadzenia danych
	li $v0, 4
	la $a0, text6
	syscall
	
	#Wczytanie danych
	li $v0, 5
	syscall
	move $t0, $v0
	
	#Odczytanie wyboru u¿ytkownika
	beq $t0, 1, wczytaj
	beq $t0, 2, dziel
	beq $t0, 3, modulo
	beq $t0, 4, koniec
	
	
	#Gdy jest poza zakresem menu, wyœwietlamy komunikt o b³êdzie
	#I odsy³amy do ponownego wprowadzenia danych
	li $v0, 4
	la $a0, textError
	syscall
	
	j pobieranieDanych
	
wczytaj:
	jal funkcjaWczytaj
	j menu
dziel:
	jal funkcjaDziel
	j menu
modulo:
	jal funkcjaModulo
	j menu
koniec:
	#Zakoñczenie programu
	li $v0, 10
	syscall
	
funkcjaWczytaj:
	#Komunikat o wczytaniu x
	li $v0, 4
	la $a0, text7
	syscall
	
	#Pobranie wartoœci x
	li $v0, 5
	syscall
	move $t5, $v0
	
	#Komunikat o wczytaniu y
	li $v0, 4
	la $a0, text8
	syscall
	
	#Pobranie wartoœci y
	li $v0, 5
	syscall
	move $t6, $v0
	
	jr $ra
	
funkcjaDziel:
	#Zabezpieczenie przed dzieleniem niewprowadzonych danych
	add $t9, $t5, $t6
	beq $t9, $zero, ERROR
	
	div $t7, $t5, $t6
	
	#Wyœwietlenie komunikatu o wyniku dzielenia
	li $v0, 4
	la $a0, text9
	syscall
	
	#Wyœwietlenie wyniku dzielenia
	li $v0, 1
	move $a0, $t7
	syscall
	jr $ra 
	
funkcjaModulo:
	#Zabezpieczenie przed dzieleniem niewprowadzonych danych
	add $s0, $t5, $t6
	beq $s0, $zero, ERROR
	
	div $t8, $t5, $t6
	mfhi $t8
	#Wyœwietlenie komunikatu o wyniku dzielenia
	li $v0, 4
	la $a0, text10
	syscall
	
	#Wyœwietlenie wyniku dzielenia
	li $v0, 1
	move $a0, $t8
	syscall
	
	jr $ra
ERROR:
	#Wyœwietlenie komunikatu o braku danych
	li $v0, 4
	la $a0, text11
	syscall
	
	j menu