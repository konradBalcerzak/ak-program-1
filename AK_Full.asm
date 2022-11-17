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
	 CPI 'n' ;wystarczy jedno porowananie poniewaz rozkaz CMA nie modyfikuje fliagi Z 
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
	 CPI '+'  ;Wystarczy jedno porownanie poniewaz rozkaz DAD nie modyfikuje flagi Z
	 CZ ADR_DOD  
	 JZ PO_WYB  
	 CPI '-'  
	 CZ ADR_OD
	 LXI H,WYB_OP
	 MOV A,M
	 CPI '-' ;potrzeba drugiego porownania bo rozkazy SUB i SBB modyfikuja flage Z
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
ADR_DOD 	 STC ;CPI modyfikuja flage CY wiec przy starcie procedury nalezy ja zresetowac
	CMC
	MOV H,B  
	 MOV L,C  ;przeniesienie pierwszej liczby do HL
	 DAD D  ;DAD D -> HL + DE = HL
	 MVI D,0
	 CC JED  ;jeśli wartość przekracza 4 pozycje
	 MOV B,H  ;przeniesienie wyniku do BC
	 MOV C,L  
	 RET  
JED 	 MVI D,'1'  ;jeśli wartość przekracza 4 pozycje to zostanie wypisana 1 na początku wyniku
	 RET  
ADR_INW 	 MOV A,B  ;przepisanie liczby do A
	 CMA  ;negacja A = !A
	 MOV B,A  ;przepisanie z powrotem do B
	 MOV A,C  
	 CMA  ;negacja
	 MOV C,A  
	 MVI D,0  ;wyzerowanie D żeby nic nie wypisywało na początku wyniku
	 RET
ADR_OD MVI L,00H
     STC ;CPI modyfikuja flage CY wiec przy starcie procedury nalezy ja zresetowac
     CMC	 
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
	 RET