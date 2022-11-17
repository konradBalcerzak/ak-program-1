ADR_DOD STC	 
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