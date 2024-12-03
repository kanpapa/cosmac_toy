*
* Motor driver program 1 for COSMAC
* SB-Assembler
*
* SW input -> motor (forward <->reverse)
*
* BUS0 --- AIN1
* BUS1 --- AIN2
* BUS2 --- BIN1
* BUS3 --- BIN2
* Q    --- PWMA/B
*
	.CR	1802	;To load the 1802 cross overlay	
	.OR	$0000
*
START	LDI	#IOR	;D <- #IOR
	PLO	5	;R(5).0 <- D
	SEX	5	;X <- 5
	SEQ
LOOP1	INP	2	;M(R(5)) <- BUS; D <- BUS
	OUT	4	;BUS <- M(R(5)); R(5)++
	DEC	5	;R(5)--
	BR	LOOP1	;Branch to LOOP1
*
IOR	.DB	0	;IO Register

	.EN
