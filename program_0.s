	.data

v1:  		.byte    	1,2,3,1,1,1,3,2,1
v2:  		.byte    	8,5,4,1,8,1,1,5,8
v3:  		.byte    	1,2,1,2,1,2,1,2,1
maxElements:	.byte		8			;9 posti -1 
vElements/2:	.byte		3			;9/2-1

flag1: 		.space 1		
flag2: 		.space 1	
flag3: 		.space 1	
v4:  		.space 9    

	.code

main:	
	lb R1, maxElements(R0)
	daddi R2, R0, 0
	

loop1:	lb R11, v1(R2)		;carico l'Resimo posto da v1 crescente
	
	lb R21, v1(R1)		;carico l'Resimo posto da v1 decrescente
	
	bne R21,R11,init2  	;esco dal loop perchè so già che non è palindromo

	daddi R1, R1, -1
	daddi R2, R2, 1

	bne R1,R2,loop1 	;clausola di iterazione del loop

setFlag1: daddi R30, R0,1
	sb R30, flag1(R0)	;set la flag ad 1
	daddi R5, R0, 9		;set un counter al contrario

sum1:	daddi R5, R5, -1	;uso il counter al contrario
	lb R7, v4(R5)
	lb R8, v1(R5)
	dadd R7,R7,R8		;eseguo la somma
	sb R7, v4(R5)		;salvo la somma in v4
	bnez R5,sum1		;clausola di iterazione del loop
	

init2:	lb R1, maxElements(R0)	;porto al corretto valore la variabile usata
	daddi R2, R0, 0		;porto a zero la variabile usata

loop2:	lb R12, v2(R2)		;carico l'Resimo posto da v2 crescente
	
	lb R22, v2(R1)		;carico l'Resimo posto da v2 decrescente

	bne R22,R12,init3  	;esco dal loop perchè so già che non è palindromo

	daddi R1, R1, -1
	daddi R2, R2, 1

	bne R1,R2,loop2 	;clausola di iterazione del loop

setFlag2: daddi R30, R0,1
	sb R30, flag2(R0)	;set la flag ad 1
	daddi R5, R0, 9		;set un counter al contrario

sum2:	daddi R5, R5, -1	;uso il counter al contrario
	lb R7, v4(R5)
	lb R8, v2(R5)
	dadd R7,R7,R8		;eseguo la somma
	sb R7, v4(R5)		;salvo la somma in v4
	bnez R5,sum2		;clausola di iterazione del loop


init3:	lb R1, maxElements(R0)
	daddi R2, R0, 0

loop3:	lb R13, v3(R2)		;carico l'Resimo posto da v3 crescente	

	lb R23, v3(R1)		;carico l'Resimo posto da v3 decrescente
		
	bne R23,R13,done  	;esco dal loop perchè so già che non è palindromo

	daddi R1, R1, -1
	daddi R2, R2, 1

	bne R1,R2,loop3		;clausola di iterazione del loop
	
setFlag3: daddi R30, R0,1
	sb R30, flag3(R0)	;set la flag ad 1
	daddi R5, R0, 9		;set un counter al contrario


sum3:	daddi R5, R5, -1	;uso il counter al contrario
	lb R7, v4(R5)
	lb R8, v3(R5)
	dadd R7,R7,R8		;eseguo la somma
	sb R7, v4(R5)		;salvo la somma in v4
	bnez R5,sum3		;clausola di iterazione del loop

done:	halt
	

	