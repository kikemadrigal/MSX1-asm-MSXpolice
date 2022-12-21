		output "holaMSX.bin"
BDOS:	equ	0005h	; Set the address 0005h into label BDOS.
			; We can call several routines under MSX-DOS at address 0005h.
 
	org	100h	; Compilation start address.
			; MSX-DOS commands start always at address 0100h.
 
	ld	de,Hello_TXT	; Load the address of the label "Hello_TXT" into DE.
	ld	c,9		; C must contain function number of the MSX-DOS.
	call	BDOS		; Call the function 9 (Print function).
	ret			; Back to the MSX-DOS environment.
 
Hello_TXT:			; Set the current address into label Hello_TXT. (text pointer)
 
	db "Hello world!$"	; The character $ (24h) indicates the end of text for function 9.
; Print "Hello world!" under MSX-BASIC using BIOS function.
;
; Save the assembled file with the name HELLO.BIN then
; Load from MSX-BASIC with: BLOAD "HELLO.BIN",R
 
CHPUT:	equ	000A2h		; Set the address of character output routine of main Rom BIOS
				; Main Rom is already selected (0000h ~ 7FFFh) under MSX-Basic
 
; --> BLOAD header, before the ORG so that the header isn’t counted
 
	db	 0FEh		; Binary file ID
	dw	 Begin		; begin address
	dw	 End - 1	; end address
	dw	 Execute	; program execution address (for ,R option)
 
	org	0C000h	; Some assemblers do not support anything other than the EQU statement above.
			; In this cas, move ORG before the header and add -7 behind. 
Begin:
 
; Program code entry point
Execute:
	ld	hl,Hello_TXT	; Load the address from the label Hello_TXT into HL.
	call	Print		; Call the routine Print below.
	ret			; Back to MSX-BASIC environment.
 
Print:
	ld	a,(hl)		; Load the byte from memory at address indicated by HL into A.
	and	a		; Same as CP 0 but faster.
	ret	z		; Back behind the call print if A = 0
	call	CHPUT		; Call the routine to display a character.
	inc	hl		; Increment the HL value.
	jr	Print		; Relative jump to the address in the label Print.
 
Hello_TXT:			; Set the current address into label Hello_TXT. (text pointer)
	db "Hello world!",0	; Zero indicates the end of text.
 
End:
; Print "Hello world!" from cartridge environment.
;
; Save the assembled file with the name HELLO.ROM then
; you can run it on emulator
 
CHPUT:		equ 0A2h	; Set the address of character output routine of main Rom BIOS
				; Main Rom is already selected (0000h ~ 3FFFh/7FFFh) when a
				; Rom is being executed.
RomSize:	equ 4000h	; For 16kB Rom size.
 
; Compilation address
	org 4000h	; 8000h can be also used here if Rom size is 16kB or less.
 
; ROM header (Put 0000h as address when unused)
	db "AB"		; ID for auto-executable Rom at MSX start
	dw Execute	; Main program execution address.
	dw 0		; Execution address of a program whose purpose is to add
			; instructions to the MSX-Basic using the CALL statement.
	dw 0		; Execution address of a program used to control a device
			; built into the cartridge.
	dw 0		; Basic program pointer contained in ROM.
	dw 0,0,0
 
; Program code entry point
Execute:
	ld	hl,Hello_TXT	; Load the address from the label Hello_TXT into HL.
	call	Print		; Call the routine Print below.
 
; Halt program execution. Change to "ret" to return to MSX-BASIC.
 
Finished:
	jr	Finished	; Jump to itself endlessly.
 
Print:
	ld	a,(hl)		; Load the byte from memory at address indicated by HL to A.
	and	a		; Same as CP 0 but faster.
	ret	z		; Back behind the call print if A = 0
	call	CHPUT		; Call the routine to display a character.
	inc	hl		; Increment the HL value.
	jr	Print		; Relative jump to the address in the label Print.
 
 
; Message data
Hello_TXT:			; Set the current address into label Hello_TXT. (text pointer)
	db "Hello world!",0	; Zero indicates the end of text.
End:
