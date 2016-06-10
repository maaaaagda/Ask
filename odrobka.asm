.data 
	tab: .space 100
	tab1: .space 100
	a: .asciiz "Wprowadz 'a': " 
	b: .asciiz "Wprowadz 'b': " 
	zakres: .asciiz "Wpisz zakres: " 
	ilosc: .asciiz "Podaj ile chcesz liczb: " 
	iloscz: .asciiz "Ilosc liczb z zakresu: " 
	liczba: .asciiz "Liczba " 
	newline: .asciiz ", "
	zzakresu: .asciiz "\nLiczby z zakresu: "
	iloczyn: .asciiz "\nIloczyn: "
	wczytane: .asciiz "\nWczytany ciag liczb: "
	wczytane2: .asciiz "\nWczytany drugi ciag liczb: "
	indeksy: .asciiz "\nIndeksy danej liczby: "
	znajdz: .asciiz "\nJaka liczbe chcesz odszukasz w swojej tablicy? : "
	dwukropek: .asciiz ": "
	tabplz: .asciiz "Druga tablica:\n"
	powtorzyc: .asciiz "\nCzy powtorzyc? (0 - koniec) "
.text


main:
#funkcja wczytaj
jal funkcja_zakres
la $s6, tab
move $t1, $s6
jal funkcja_wczytaj

# funkcja sumuj
jal funkcja_sumuj

#funkcja powtorz
powtorz:
		#czapytanie o powtorzenie
		li $v0, 4
		la $a0, powtorzyc
		syscall
		
		#wczytanie liczby
		li $v0, 5
		syscall
		
		bne $v0, $0, main
		
		li $v0, 10
		syscall		

funkcja_zakres:
	#wczytanie ilosci liczb
	li $v0, 4
	la $a0, zakres
	syscall
	
	#wczytaj a
	li $v0, 4
	la $a0, a
	syscall
	
	#wczytanie liczby
	li $v0, 5
	syscall	
	move $s4, $v0	

	#wczytaj b
	li $v0, 4
	la $a0, b
	syscall	
	
	#wczytanie liczby
	li $v0, 5
	syscall	
	move $s2, $v0
	
	jr $ra
funkcja_wczytaj:
   	
	#wczytanie ilosci liczb
	li $v0, 4
	la $a0, ilosc
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0
	move $s1, $t0

	# w $t4 ostatnia liczba tablicy
	mul $t4, $t0, 4		
	
	#wyzeruj
	
	move $t3, $0
	
	addi $t8, $0, 1
	move $t7, $0
	
	wczytaj:
		
		#licznik						
		addi $t3, $t3, 1
		
		#podanie liczby
		li $v0, 4
		la $a0, liczba
		syscall
		
		#licznik
		li $v0, 1
		move $a0, $t3
		syscall
		
		#dwukropek
		li $v0, 4
		la $a0, dwukropek
		syscall
		
		#wczytanie liczby
		li $v0, 5
		syscall
		move $t6, $v0
		
		#zapisanie liczby do tablicy
		sw $t6, ($t1)
		addi $t1, $t1, 4
		addi $t0, $t0, -1
		bne $t0, $0, wczytaj
	
	
		jr $ra	
		

	
funkcja_sumuj:
	#wyzerowanie $t1
		move $t1, $0
		move $t3, $0
		move $t9, $0
		move $t5, $0
		move $t8, $0
		move $t7, $0
		
		#nowa linia
		li $v0, 4
		la $a0, zzakresu
		syscall
	
				
	zapisz:	
		#dopóki nie ma konca tablicy
		beq $t1, $t4, endd
		
		
		#³adowanie s³owa
		lw $t5, ($s6)
		
		
		ble $s2, $t5, niedodawaj
		bge $s4, $t5, niedodawaj


		
		#wypisanie liczby z tablicy
				
		li $v0, 1
		move $a0, $t5
		syscall
		
		addi $t9, $t9, 1 
		
		#add $t7, $t5, $t8
		
		#sw $t7, tab12($t9)
		#addi $t9, $t9, 4
		
		#wypisanie liczby z tablicy
		#li $v0, 1
		#move $a0, $t7
		#syscall
		
		
		
		#nowa linia
		li $v0, 4
		la $a0, newline
		syscall
		
		niedodawaj:
		
		addi $s6, $s6, 4 
		addi $t1, $t1, 4 
		
		j zapisz
		

	
	
	
	endd:	
	#nowa linia
	li $v0, 4
	la $a0, iloscz
	syscall
	
	li $v0, 1
	move $a0, $t9
	syscall
			
	jr $ra		


	

		
						
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
