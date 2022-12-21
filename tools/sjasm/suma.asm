		output "suma.bin"
		
		
CHPUT:	equ	#00A2		; CHPUT es solo una etiqueta que se pone para no estar llamado a la subrutina 0042h
						; Muestra un carácter
						; MSX-1 BIOS subrutines
						; Definiciones de subrutinas creadas para la bios 
						; http://map.grauw.nl/resources/msxbios.php

	;esto es oblgatorio para definir la cabecera de un archivo BIN
	db	 0FEh		; ID archivo binario
	dw	 INICIO		; dirección de inicio
	dw	 FINAL - 1	; dirección final
	dw	 MAIN	    ; dircción del programa de ejecución (para cuando pongas r en bload"nombre_programa", r)
	
	
 
	org	0C000h	; org se utiliza para decirle al z80 en que posición de memoria empieza nuestro programa
			
INICIO:
 

 

MAIN:
	ld a,3
	ld (bc),a
	add a,4
	call CHPUT
	ret
FINAL:
