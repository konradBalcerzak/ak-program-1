
;Przyjmuje:    
;BC - pierwsza liczba    
;DE - druga liczba    
;Wynik w rejestrze BC    
;Znak wyniku w rejestrze D('-' lub 00H) 
;sprawdzenie czy pierwsza liczba jest wieksza od drugiej    
;Odejmujemy liczbe 2 od liczby 1, jesli nastapi przenisienie(flaga CY=1) to znaczy ze liczba 2 jest wieksza
ADR_OD STC
     CMC
     MVI L,00H	        
	 MOV A,B  
	 SUB D  
	 JC OD_SWAP  
	 JZ OD_YOUNG_TEST1  
	 JMP OD_SUBSTRACT  
;Jesli starsze bajty obu liczb sa sobie rowne, porownujemy mlodzse bajty w ten sam sposób    
OD_YOUNG_TEST1 	   MOV A,C  
	 SUB E  
	 JC OD_SWAP  
	 JMP OD_SUBSTRACT    
;Jesli druga liczba jest wieksza od pierwszej, zamieniamy je miejsciami a wynik bedzie ujemny, na L wrzuca znak '-'  
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
