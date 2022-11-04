
;Przyjmuje:    
;BC - pierwsza liczba    
;DE - druga liczba    
;Wynik w rejestrze BC    
;Znak wyniku w rejestrze D('-' lub 00H) 
;sprawdzenie czy pierwsza liczba jest wieksza od drugiej    
;jesli 8 bitowa liczba jest wieksza niz 7Fh(0111 1111) w assembler jest uznawana za ujemna poniewaz jest pierwszy bit jest rowny 1    
;wiec jesli obie liczby sa wieksze od 7Fh, odejmuje sie od nich wartosc 80h, nastepnie sa odejmowane od siebie    
;Jeslie tylko jedna z nich jest wieksza niz 7Fh, to wiadomo ktora jest wieksza    
;jesli obie sa mniejsze, to wykonuje sie odejmowanie aby je porownac
;test czy liczba jest wieksza od 7Fh jest wykonanywany przez dodanie wartosci 80H(1000 0000), jesli pierwszy bit jest rowny 1, to liczba byla mniejsza od 80H
;Jesli wynosi 0, liczba byla wieksza od 80H    
ADR_OD MVI L,00H	 
	 MOV A,B  
	 ADI 80H  
	 JP OD_OLDER_TEST2  
	 MOV A,D  
	 ADI 80H  
	 JP OD_SWAP  
	 MOV A,B  
	 SUB D  
	 JM OD_SWAP  
	 JZ OD_YOUNG_TEST1  
	 JMP OD_SUBSTRACT  
;Jesli starzy bajt pierwszej liczby jest wiekszy od 7Fh    
OD_OLDER_TEST2 	 MOV A,D  
	 ADI 80H  
	 JM OD_SUBSTRACT  
	 MOV A,D  
	 SUI 80H  
	 MOV H,A  
	 MOV A,B  
	 SUI 80H  
	 SUB H  
	 JZ OD_YOUNG_TEST1  
	 JM OD_SWAP  
	 JMP OD_SUBSTRACT  
;Jesli starsze bajty obu liczb sa sobie rowne, porownujemy mlodzse bajty w ten sam sposób    
OD_YOUNG_TEST1 	 MOV A,C  
	 ADI 80H  
	 JP OD_YOUNG_TEST2  
	 MOV A,E  
	 ADI 80H  
	 JP OD_SWAP  
	 MOV A,C  
	 SUB E  
	 JM OD_SWAP  
	 JMP OD_SUBSTRACT  
OD_YOUNG_TEST2 	 MOV A,E  
	 ADI 80H
	JM OD_SUBSTRACT  	 
	 MOV A,E  
	 SUI 80H  
	 MOV H,A  
	 MOV A,C  
	 SUI 80H  
	 SUB H  
	 JM OD_SWAP  
	 JMP OD_SUBSTRACT  
;Jesli druga liczba jest wieksza od pierwszej, zamieniamy je miejsciami a wynik bedzie ujemny, na L wrzuca 2  
OD_SWAP 	 MOV H,B  
	 MOV L,C  
	 MOV B,D  
	 MOV C,E  
	 MOV D,H  
	 MOV E,L  
     MVI L,'-'
     
;Procedura odejmowania, resetuje flage CY    
OD_SUBSTRACT 	 STC  
	 CMC  
	 MOV A,C  
	 SUB E  
	 MOV C,A  
	 MOV A,B  
	 SBB D  
	 MOV B,A  
     MOV D,L	
     MVI A,0	 
	 RET
