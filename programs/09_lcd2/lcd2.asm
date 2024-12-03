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
START	LDI	#MAIN
	PLO	3
	LDI	#WAIT1
	PLO	7
	LDI	#SEND1
	PLO	8
*	LDI	#0
*	PHI	3
*	PHI	7
*	PHI	8
*
	SEP	3	; Jump MAIN
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
	PLO	4		;D -> R(4).0
	SEX	4		;4 -> X
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
	SEP	7		;Call WaitSub
*
* Function set (Interface is 8bits long.)
*
	OUT	4		;M(R(X))->BUS, R(X)++
*
* Wait 100us
*
	LDI	#2		;Load immediate value 2 into 0
	SEP	7		;Call WaitSub
*
* Send Initrize command (8byte)
*
	LDI	#8		;Send 8 byte
	SEP	8		;Call SEND
*
* Wait 1.64ms
*
	LDI	#32		;Load immediate value 32 into 0
	SEP	7
*
* Send Enrty Mode Set/Set Address
*
	LDI	#4		;Send 4 byte
	SEP	8		;Call SEND
*
* SET Register Select
*
	SEQ			;RS=1
*
* Write data to RAM
*
	LDI	#6		;Send 6 byte
	SEP	8		;Call SEND
*
* RESET Register Select
*
	REQ			;RS=0
*
STOP	BR	STOP		;HALT
*
* WAIT SUB ROUTINE
*
EXIT1	SEP	3
WAIT1	PLO	5		;Put D in R5,0
LOOP2	DEC	5		;Decrement R5 by 1 over 8 bits
	GLO	5		;Get R5.0 to test
	BNZ	LOOP2		;If R5.0 != 0, branch to LOOP
	BR	EXIT1
*
* SEND n byte SUB ROUTINE
*
EXIT2	SEP	3
SEND1	PLO	5		;D -> R(5).0
LOOP6	OUT	4		;M(R(X)) -> BUS; R(X)++
	DEC	5		;R(5).0--
	GLO	5		;R(5).0 -> D
	BNZ	LOOP6
	BR	EXIT2

	.EN
