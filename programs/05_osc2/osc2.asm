*
* Oscillator program 2 for COSMAC
* SB-Assembler
*
	.CR	1802
	.OR	$0000
*
START	LDI	#IOR	;D <- #IOR
	PLO	5	;R(5).0 <- D
	SEX	5	;X <- 5
LOOP1	INP	2	;M(R(5)) <- BUS;N LINES=2
	LDN	5	;D <- M(R(5))
	PLO	3	;R(3).0 <- D
LOOP2	DEC	3	;R(3)--
	GLO	3	;D <- R(3).0
	BNZ	LOOP2	;IF D!=0 LOOP2
	SEQ		;Q <- 1
	REQ		;Q <- 0
	BR	LOOP1	;Branch to LOOP1
*
IOR	.DB	0	;IO Register

	.EN
