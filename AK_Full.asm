	 ORG 800H  
; Program  
PTL_WYB 	 LXI H,PIERW  
	 RST 3  
	 RST 5  
	 CALL OUT_CRLF  
	 LXI H,WYBIERZ  
	 RST 3  
	 LXI H,AKCJA_1  
	 RST 3  
	 LXI H,AKCJA_2  
	 RST 3  
	 LXI H,AKCJA_3  
	 RST 3  
	 MVI A,'>'  
	 RST 1  
	 MVI A,' '  
	 RST 1  
	 LXI H,WYB_OP  
	 RST 2  
	 MOV M,A  
	 CALL OUT_CRLF  
	 MOV A,M  
	 LXI H,WYB_OP  
	 MOV A,M  
	 MOV B,D  
	 MOV C,E  
	 CPI '2'  
	 CZ ADR_INW  
	 JZ PO_WYB  
	 LXI H,DRUGA  
	 RST 3  
	 RST 5  
	 CALL OUT_CRLF  
	 LXI H,WYB_OP  
	 MOV A,M  
	 CPI '1'  
	 CZ ADR_DOD  
	 JZ PO_WYB   ;Szybki fix do odejmowania	 
	 CPI '3'  
	 CZ ADR_OD
	 LXI H,WYB_OP
	 MOV A,M
	 CPI '3'
	 JZ PO_WYB  
	 JMP PTL_WYB  
PO_WYB 	 MOV A,D ; D powinno zawierac wartosc 0-2  
	 CPI 0  
	 JZ WYSWIETL_WYNIK  
	 MOV A,D  
	 RST 1  
WYSWIETL_WYNIK 	 MOV A,B  
	 RST 4  
	 MOV A,C  
	 RST 4  
	 MVI A,'h'  
	 RST 1  
	 CALL OUT_CRLF  
	 HLT  
; Zmienne       
WYB_OP 	 DB 0 ; Zmienna jaka operacja zostala wybrana przez uzytjkownika              
; Procedury     
OUT_CRLF 	 MVI A,13  
	 RST 1  
	 MVI A,10  
	 RST 1  
	 RET  
; lancuchy  
WYBIERZ 	 DB 'Wybierz akcje:',13,10,'@'  
AKCJA_1 	 DB '1) Dodawanie',13,10,'@'  
AKCJA_2 	 DB '2) Inwersja',13,10,'@'  
AKCJA_3 	 DB '3) Odejmowanie',13,10,'@'  
PIERW 	 DB 'Liczba jeden:',13,10,'> @'  
DRUGA 	 DB 'Liczba 2:',13,10,'> @'  
; Procedury kalkulatora  
ADR_DOD 	 RET  
ADR_INW 	 RET  
;Przyjmuje:    
;BC - pierwsza liczba    
;DE - druga liczba    
;Wynik w rejestrze BC    
;Znak wyniku w rejestrze D('-' lub 00H) 
;sprawdzenie czy pierwsza liczba jest wieksza od drugiej    
;Odejmujemy liczbe 2 od liczby 1, jesli nastapi przenisienie(flaga CY=1) to znaczy ze liczba 2 jest wieksza
ADR_OD MVI L,00H	        
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
