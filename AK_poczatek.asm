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
	 LXI H,AKCJA_4  
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
	 CPI 'n'  
	 CZ ADR_INW  
	 JZ PO_WYB
	 CPI 'x'
	 JZ EXIT
	 LXI H,DRUGA  
	 RST 3  
	 RST 5  
	 CALL OUT_CRLF  
	 LXI H,WYB_OP  
	 MOV A,M  
	 CPI '+'  
	 CZ ADR_DOD  
	 JZ PO_WYB   ;Szybki fix do odejmowania	 
	 CPI '-'  
	 CZ ADR_OD
	 LXI H,WYB_OP
	 MOV A,M
	 CPI '-'
	 JZ PO_WYB  
	 JMP PTL_WYB  
PO_WYB LXI H,WYNIK
     RST 3	 
	 MOV A,D ; D powinno zawierac wartosc 0-2  
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
     JMP PTL_WYB 
EXIT HLT  
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
AKCJA_1 	 DB '+) Dodawanie',13,10,'@'  
AKCJA_2 	 DB 'n) Inwersja',13,10,'@'  
AKCJA_3 	 DB '-) Odejmowanie',13,10,'@'  
AKCJA_4      DB 'x)Zakoncz program',13,10,'@'
PIERW 	 DB 'Liczba 1:',13,10,'> @'  
DRUGA 	 DB 'Liczba 2:',13,10,'> @'
WYNIK    DB 'Wynik:@' 
; Procedury kalkulatora  
ADR_DOD 	 RET  
ADR_INW 	 RET  
ADR_OD 	 RET  
