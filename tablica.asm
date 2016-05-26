.data
	tab: .space 100
	ilosc: .asciiz "Podaj ile chcesz liczb: " 
	liczba: .asciiz "Liczba " 
	newline: .asciiz ", "
	licznikzer: .asciiz "Ilosc danej liczby: "
	wczytane: .asciiz "Wczytane liczby: "
	indeksy: .asciiz "\nIndeksy danej liczby: "
	znajdz: .asciiz "\nJaka liczbe chcesz odszukasz w swojej tablicy? : "
	dwukropek: .asciiz ": "
.text
   main:	
	jal wczytaj_ilosc
	
	jal zapisz_ostatni
	
	#wyzeruj
	move $t1, $0
	move $t3, $0
	
	wczytaj:
		beq $t0, $0, funkcja_wczytaj
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
		move $t2, $v0
		
		#zapisanie liczby do tablicy
		sw $t2, tab($t1)
		addi $t1, $t1, 4
		addi $t0, $t0, -1
		j wczytaj
		
funkcja_wczytaj:
		#wyzerowanie $t1
		move $t1, $0
		move $t3, $0
		
		#podanie liczby
		li $v0, 4
		la $a0, wczytane
		syscall
				
	wypisz:	
		#dopóki nie ma konca tablicy
		beq $t1, $t4, next
		
		#³adowanie s³owa
		lw $t5, tab($t1)
		addi $t1, $t1, 4 
		
		#wypisanie liczby z tablicy
		li $v0, 1
		move $a0, $t5
		syscall
		
		#nowa linia
		li $v0, 4
		la $a0, newline
		syscall
		
		#zliczenie zer
		#bne $t5, $0, wypisz
		#addi $t7, $t7, 1
		j wypisz

next:

		#wyzerowanie $t1
		move $t1, $0
		move $t7, $0
		
		jal znajdz_liczbe
		
		#indeksy
		li $v0, 4
		la $a0, indeksy
		syscall
		
		wypisz_indeksy:
		
		#dopóki nie ma konca tablicy
		beq $t1, $t4, koniec
		
		#³adowanie s³owa
		lw $t5, tab($t1)
		addi $t1, $t1, 4 
		
		
		
		bne $t5, $s1, wypisz_indeksy
		div $t8, $t1, 4 
		
		#wypisanie indeksu z tablicy
		li $v0, 1
		move $a0, $t8
		syscall
		
		#nowa linia
		li $v0, 4
		la $a0, newline
		syscall
		
		
		addi $t7, $t7, 1
		j wypisz_indeksy	
	
koniec:
	#nowa linia
		li $v0, 4
		la $a0, licznikzer
		syscall
	
	#wypisanie liczby z tablicy
		li $v0, 1
		move $a0, $t7
		syscall
	#koniec	
		li $v0, 10
		syscall			

wczytaj_ilosc:
	#wczytanie ilosci liczb
	li $v0, 4
	la $a0, ilosc
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0
	jr $ra
	
zapisz_ostatni:

	# w $t4 ostatnia liczba tablicy
	mul $t4, $t0, 4		
	jr $ra
	
znajdz_liczbe:
		#podanie liczby
		li $v0, 4
		la $a0, znajdz
		syscall
		
		#wczytanie liczby
		li $v0, 5
		syscall
		move $s1, $v0
		
		jr $ra