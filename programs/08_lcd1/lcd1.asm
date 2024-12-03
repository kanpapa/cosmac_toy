*
* SC1602 LCD Display program 1 for COSMAC
* SB-Assembler
*
	.CR	1802	;To load the 1802 cross overlay	
	.OR	$0000
*
* CDP1802        SC1602LCD
* TPB---AND----> E(6)
* N2-----+
* Q -----------> RS(4)
* BUS0 --------> DB4(11)
* BUS1 --------> DB5(12)
* BUS2 --------> DB6(13)
* BUS3 --------> DB7(14)
*         GND--> R/W(5)
*         GND--> GND(2)
*         +5V--> VDD(1)
*
START	BR	MAIN
*
*---------------------------
* LCD Initialize Data(4bit mode, RS=0)
*---------------------------
INTDAT	.DB	$03		;Function set (Interface is 8bits long.)
*				;wait 4.1ms
	.DB	$03		;Function set (Interface is 8bits long.)
*				;wait 100us
	.DB	$03		;Function set (Interface is 8bits long.)
*				;wait 40us
	.DB	$02		;Function set (Set interface to be 4 bits long.)
*				;wait 40us
	.DB	$02		;Function set (2Line mode)
	.DB	$08		;
*				;wait 40us
	.DB	$00		;Display OFF, Cursor OFF, Blink OFF
	.DB	$08		;
*				;wait 40us
	.DB	$00		;Clear Display
	.DB	$01		;
*				;wait 1.64ms
	.DB	$00		;Entry Mode Set(Cursor right, shift off)
	.DB	$06		;
*				;wait 40us
	.DB	$00		;Display ON, Cursor OFF, Blink OFF
	.DB	$0C		;
*				;wait 40us
*---------------------------
* LCD Display data(4bit mode, RS=1)
*---------------------------
	.DB	$03		;"1"
	.DB	$01		;
*				;wait 40us
	.DB	$03		;"2"
	.DB	$02		;
*				;wait 40us
	.DB	$03		;"3"
	.DB	$03		;
*				;wait 40us
*----------------------
* Main routine
*----------------------
MAIN	REQ			;RS=0
	LDI	#INTDAT		;INTDAT -> D
	PLO	3		;D -> R(3).0
	SEX	3		;3 -> X
*
* LCD Initrize
*
* Function set (Interface is 8bits long.)
*
	OUT	4		;M(R(X))->BUS, R(X)++
*
* Wait 4.1ms
*
	LDI	#64		;Load immediate value 170 into 0
	PLO	5		;Put D in R5,0
LOOP1	DEC	5		;Decrement R5 by 1 over 8 bits
	GLO	5		;Get R5.0 to test
	BNZ	LOOP1		;If R5.0 != 0, branch to LOOP
*
* Function set (Interface is 8bits long.)
*
	OUT	4		;M(R(X))->BUS, R(X)++
*
* Wait 100us
*
	LDI	#2		;Load immediate value 2 into 0
	PLO	5		;Put D in R5,0
LOOP2	DEC	5		;Decrement R5 by 1 over 8 bits
	GLO	5		;Get R5.0 to test
	BNZ	LOOP2		;If R5.0 != 0, branch to LOOP
*
* 
*
	LDI	#8		;Loop 8 count
	PLO	5		;D -> R(5).0
LOOP3	OUT	4		;M(R(3))->BUS, R(3)++
	DEC	5		;R(5).0--
	GLO	5		;R(5).0 -> D
	BNZ	LOOP3
*
* Wait 1.64ms
*
	LDI	#32		;Load immediate value 32 into 0
	PLO	5		;Put D in R5,0
LOOP4	DEC	5		;Decrement R5 by 1 over 8 bits
	GLO	5		;Get R5.0 to test
	BNZ	LOOP4		;If R5.0 != 0, branch to LOOP
*
* Send Enrty Mode Set/Set Address
*
	LDI	#4		;Loop 4 count
	PLO	5		;D -> R(5).0
LOOP5	OUT	4		;M(R(3))->BUS, R(3)++
	DEC	5		;R(5).0--
	GLO	5		;R(5).0 -> D
	BNZ	LOOP5
*
* SET Register Select
*
	SEQ			;RS=1
*
* Write data to RAM
*
	LDI	#6		;Loop 6 count
	PLO	5		;D -> R(5).0
LOOP6	OUT	4		;M(R(3)) -> BUS; R(3)++
	DEC	5		;R(5).0--
	GLO	5		;R(5).0 -> D
	BNZ	LOOP6
*
* RESET Register Select
*
	REQ			;RS=0
*
STOP	BR	STOP		;HALT
*
	.EN
