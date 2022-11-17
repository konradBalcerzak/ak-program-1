ADR_INW 	 MOV A,B  ;przepisanie liczby do A
	 CMA  ;negacja A = !A
	 MOV B,A  ;przepisanie z powrotem do B
	 MOV A,C  
	 CMA  ;negacja
	 MOV C,A  
	 MVI D,0  ;wyzerowanie D żeby nic nie wypisywało na początku wyniku
	 RET