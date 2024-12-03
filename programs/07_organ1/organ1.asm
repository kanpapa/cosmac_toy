*
* Electronic organ program 1 for COSMAC
* SB-Assembler
*
	.CR	1802
	.OR	$0000
*
START	BR	MAIN
*
DATA	.DB	$23	;C
	.DB	$26	;B
	.DB	$2B	;A
	.DB	$31	;G
	.DB	$38	;F
	.DB	$3B	;E
	.DB	$43	;D
	.DB	$4C	;C
*
MAIN	BN4	MAIN	;IF EF4=0 MAIN 
	LDI	#IOR	;D <- #IOR
	PLO	3	;R(3).0 <- D
	SEX	3	;X <- 3
	INP	4	;M(R(3)) <- BUS;N LINES=4
	LDN	3	;D <- M(R(3))
	ADI	DATA	;D,DF <- DATA+D
	PLO	4	;R(4).0 <- D
	LDN	4	;D <- M(R(4))
	PLO	5	;R(5).0 <- D
LOOP2	DEC	5	;R(5)--
	GLO	5	;D <- R(5).0
	BNZ	LOOP2	;IF D!=0 LOOP2
	BQ	LOOP3	;IF Q=0 LOOP3
	SEQ		;Q <- 1
	BR	MAIN	;Branch to MAIN
*
LOOP3	REQ		;Q <- 0
	BR	MAIN	;Branch to MAIN
*
IOR	.DB	0	;IO Register

	.EN
