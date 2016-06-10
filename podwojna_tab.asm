.data
	tab: .space 100
	tab1: .space 100
	tab12: .space 100
	ilosc: .asciiz "Podaj ile chcesz liczb: " 
	liczba: .asciiz "Liczba " 
	newline: .asciiz ", "
	suma: .asciiz "\nSuma: "
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
la $s6, tab
move $t1, $s6
jal funkcja_wczytaj
# funkcja wyswietl
la $s7, tab1
move $t1, $s7
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
		la $a0, suma
		syscall
	
				
	zapisz:	
		#dop�ki nie ma konca tablicy
		beq $t1, $t4, endd
		
		
		#�adowanie s�owa
		lw $t5, ($s6)
		lw $t8, ($s7)
		
		
		bne $t5, $t8, niewypisuj
		#wypisanie liczby z tablicy
		div $s4, $t1, 4
		addi $s4, $s4, 1
		li $v0, 1
		move $a0, $s4
		syscall
		
		
		
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
		
		niewypisuj:
		addi $s7, $s7, 4 
		addi $s6, $s6, 4 
		addi $t1, $t1, 4 
		
		j zapisz
		

	
	
	
	endd:	
	jr $ra		


	

		
						
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
