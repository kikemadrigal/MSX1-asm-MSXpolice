        output "main.bin"

    db   #fe               ; ID archivo binario, siempre hay que poner el mismo 0FEh
    dw   INICIO             ; dirección de inicio
    dw   FINAL - 1          ; dirección final
    dw   INICIO               ; dircción del programa de ejecución (para cuando pongas r en bload"nombre_programa", r)

    org 33280               ; org se utiliza para decirle al z80 en que posición de memoria empieza nuestro programa (es la 33280 en decimal), en hezadecimal sería #8200



INICIO:
    ;***********************musica****************/
    di	
	ld		hl,SONG-99		; hl vale la direccion donde se encuentra la cancion - 99
	call	PT3_INIT			; Inicia el reproductor de PT3
	ei
    ;***************Fin de música****************/
    call screen2x16
    call cargar_tiles_colores_y_screen1 ;cargamos la pantalla con la foto de presentación
    call CHGET ;esperamos a que se pulse un tecla, cuando se pulse cambiará la pantalla a screen screen2 (la 1)
    call cargar_tiles__colores_screen2
    call cagar_coche_y_enemigos_screen2
    call cargar_map_screen2
    call cargar_sprites

    call .bucle
    ret
.bucle:
    ;***************Ir reproduciendo bloques de música**************/
    halt						;sincronizacion
	di
	call	PT3_ROUT			;envia datos a al PSG
	call	PT3_PLAY			;prepara el siguiente trocito de cancion que sera enviada mas tarde al PSG
	ei
	;***************Fin de ir reproduciendo bloques de música*******/

    ;halt ;espera a la interrupción VBlank del VDP y sincroniza
    call chekear_teclado
    ;call analizar_colisiones
    call actualiza_atributos_de_coche_sprite
    call actualiza_atributos_de_enemigo_sprite
    ;call actualiza_atributos_de_enemigo2_sprite
    call actualiza_atributos_de_contenedor_sprite
    call actualiza_posicion_enemigo
    call incrementa_posicion_x_contedor
    ;call actualiza_atributos_de_numeros_sprite
    call volcar_sprite_coche_atributos_en_VRAM
    call volcar_sprite_enemigo_atributos_en_VRAM
    ;call volcar_sprite_enemigo2_atributos_en_VRAM
    call volcar_sprite_contenedor_atributos_en_VRAM
    ;call volcar_sprite_numeros_atributos_en_VRAM
    ;call inteligencia_enemigo
    call analizar_colisiones
    jr .bucle
  
chekear_teclado:
    di
    call cursores
    ei
    ret

analizar_colisiones:
    ld a,(STATFL)
    bit 5,a ; mira el valor del bit 5 almacenado en el registro a y que antes hemos copiado con RDVDP es el de la colision del reg. de lectura del VDP
            ;queda a 1 si está activo
    call nz,termina_partida ; si hay una colision termina partida
    ret
termina_partida:
    call poner_coche_punto_inicial
    call poner_enemigo_punto_inicial
    call poner_pantalla_inicial
    ret

muestra_colision:
    ld a,(numeros_posicion_x)
    add 20
    ld (numeros_posicion_x),a
    ret

poner_pantalla_inicial:
    ;ld a,2
    ;ld (screen_actual),a
    ;call cargar_map_screen1
    ret
incrementar_pantalla:
    ld a,(screen_actual)
    add 1
    ld (screen_actual),a
    cp 1,termina_partida
    jp z,
    cp 2
    jp z, cargar_map_screen2
    cp 3
    jp z, cargar_screen3
    cp 4
    jp z, cargar_screen4
    cp 5
    jp z, cargar_screen5
    ld a,2
    ld (screen_actual),a
    ret



;Es la pantalla con la foto
cargar_tiles_colores_y_screen1:
;Para comprender como se distrivuye la memoria del VDP ir a: https://sites.google.com/site/multivac7/files-images/TMS9918_VRAMmap_G2_300dpi.png
;-----------------------------Tileset -------------------------------------------
    ;screen1 es el splash_screen o pantalla incial con la foto de presentación
    ld hl, tiles_screen1 ; la rutina LDIRVM necesita haber cargado previamente la dirección de inicio de la RAM, para saber porqué he puesto 0000 fíjate este dibujo https://sites.google.com/site/multivac7/files-images/TMS9918_VRAMmap_G2_300dpi.png ,así es como está formado el VDP en screen 2
    ld de, #0000 ; la rutina necesita haber cargado previamente con de la dirección de inicio de la VRAM          
    ld bc, #1800; son los 3 bancos de #800
    ;call  LDIRVM ; Mira arriba, pone la explicación
    call depack_VRAM   
    ;call unpack 
;--------------------------------Colores--------------------------------------
    ld hl, color_screen1
    ld de, #2000 
    ld bc, #1800 ;son los 3 bancos de #800
    ;call  LDIRVM
    call depack_VRAM
    ;call unpack
;------------------------------Mapa o tabla de nombres-------------------------------
    ld hl, map_screen1
    ld de, #1800 
    ld bc, #300
    ;call  LDIRVM
    call depack_VRAM
    ;call unpack   
    ret
;*************************Final de cargar_pantalla_screen1 la de la foto**********************
















;*********************Comienza la 1 pantalla del juego****************************
;Esta es la pantalla donde el coche empieza abajo a la izquierda y pone comisaría
cargar_tiles__colores_screen2:
;-----------------------------Tileset -------------------------------------------
    ld hl, tiles_screen2 ; la rutina LDIRVM necesita haber cargado previamente la dirección de inicio de la RAM, para saber porqué he puesto 0000 fíjate este dibujo https://sites.google.com/site/multivac7/files-images/TMS9918_VRAMmap_G2_300dpi.png ,así es como está formado el VDP en screen 2
    ld de, #0000 ; la rutina necesita haber cargado previamente con de la dirección de inicio de la VRAM          
    ld bc, #1800; son los 3 bancos de #800
    ;call  LDIRVM ; Mira arriba, pone la explicación
    call depack_VRAM   
    ;call unpack 
;--------------------------------Colores--------------------------------------
    ld hl, color_screen2 
    ld de, #2000 
    ld bc, #1800 ;son los 3 bancos de #800
    ;call  LDIRVM
    call depack_VRAM
    ;call unpack
;------------------------------Mapa o tabla de nombres-------------------------------
    ret

cargar_map_screen2:
    ld a,2
    ld (screen_actual),a
    ;*****Posición coche al final de la pamtalla para desarrollo****
    ;ld a,205 ;developer 
    ;ld (posicion_x),a
    ;ld a,20 ;developer
    ;ld (posicion_y),a
    ;***************************************************************

    ld hl, map_screen2
    ld de,buffer_de_colsiones ;call unpack pasará todo el mapa a esta dirección
    ld bc, #300
    ;call  LDIRVM
    ;call depack_VRAM
    call unpack
    ;call unpack
    ld hl, buffer_de_colsiones ;recupramos nuestro mapa y lo volcamos al VRAM
    ld de, #1800 
    ld bc, 768
    call  LDIRVM 
;*************************Final de cargar_pantalla_splash_screen**********************
    ret


cagar_coche_y_enemigos_screen2:
    ;*******coche*******************************/
    call inicializacion_variables_coche_sprite
    call actualiza_atributos_de_coche_sprite
    call volcar_sprite_coche_atributos_en_VRAM
    ;**********Fin de coche*********************/

    ;************enemigo*************************/
    call inicializacion_variables_enemeigo_sprite
    call actualiza_atributos_de_enemigo_sprite
    call volcar_sprite_enemigo_atributos_en_VRAM
    call seleccion_ruta_dos_enemigo
    ;*************Fin de enemigo******************/

    ;************enemigo 2*************************/
    ;call inicializacion_variables_enemeigo2_sprite
    ;call actualiza_atributos_de_enemigo2_sprite
    ;call volcar_sprite_enemigo2_atributos_en_VRAM
    ;call seleccion_ruta_tres_enemigo2
    ;*************Fin de enemigo******************/

    ;******************contenedor****************/
    call inicializacion_variables_contendor_sprite
    call actualiza_atributos_de_contenedor_sprite
    call volcar_sprite_contenedor_atributos_en_VRAM
    ;*************Fin de contendor******************/

    ret
;***********Fin de la 1 pantalla del juego************************













cargar_screen3:
    call poner_coche_en_posicion_screen3
    call seleccion_ruta_dos_contenedor
    call seleccion_ruta_cuatro_enemigo

    ;*****Posición coche al final de la pamtalla para desarrollo****
    ;ld a,200 ;developer 
    ;ld (posicion_x),a
    ;ld a,75 ;developer
    ;ld (posicion_y),a
    ;***************************************************************



    ld hl, map_screen3
    ld de,buffer_de_colsiones ;call unpack pasará todo el mapa a esta dirección
    ld bc, #300
    ;call  LDIRVM
    ;call depack_VRAM
    call unpack
    ;call unpack
    ld hl, buffer_de_colsiones ;recupramos nuestro mapa y lo volcamos al VRAM
    ld de, #1800 
    ld bc, 768
    call  LDIRVM 

    ret






;En esta pantalla le he puesto un 4 en el centro
cargar_screen4:
    call poner_coche_en_posicion_screen4
    call seleccion_ruta_tres_contenedor
    call seleccion_ruta_cuatro_enemigo
    ld hl, map_screen4
    ld de,buffer_de_colsiones ;call unpack pasará todo el mapa a esta dirección
    ld bc, #300
    ;call  LDIRVM
    ;call depack_VRAM
    call unpack
    ;call unpack
    ld hl, buffer_de_colsiones ;recupramos nuestro mapa y lo volcamos al VRAM
    ld de, #1800 
    ld bc, 768
    call  LDIRVM 

    ret
cargar_screen5:
    call poner_coche_en_posicion_screen5
    call seleccion_ruta_cuatro_contenedor
    call seleccion_ruta_dos_enemigo
    ld hl, map_screen5
    ld de,buffer_de_colsiones ;call unpack pasará todo el mapa a esta dirección
    ld bc, #300
    ;call  LDIRVM
    ;call depack_VRAM
    call unpack
    ;call unpack
    ld hl, buffer_de_colsiones ;recupramos nuestro mapa y lo volcamos al VRAM
    ld de, #1800 
    ld bc, 768
    call  LDIRVM 

    ret

cargar_sprites:
    ;coche son 4 spites=4*32=128 bytes
    ld hl, sprites_coche
    ld de, 14336; #3800
    ld bc, 32*4 
    call  LDIRVM 
    ;Enemigo 8 sprites
    ld hl, sprites_enemigo
    ld de, 14336+128; #3800
    ld bc, 32*8 ; los enemigos tambien son 32 bytes de cada sprite por 4 sprites
    call  LDIRVM 
    ;Enemigo2 8 sprites
    ;ld hl, sprites_enemigo2
    ;ld de, 14336+128+256; #3800
    ;ld bc, 32*8 ; los enemigos tambien son 32 bytes de cada sprite por 4 sprites
    ;call  LDIRVM 
    ;contendor son 2 sprites
    ld hl, sprites_contedor
    ld de, 14336+128+256; #3800
    ld bc, 64 ; los sprites del numero es 1
    call  LDIRVM 
    ;Numeros
    ld hl, sprites_numeros
    ld de, 14336+128+256+64; #3800
    ld bc, 32 ; los sprites del numero es 1
    call  LDIRVM 


    ret


salir_menu_principal:
    
    ret



















   
inicializar_modo_pantalla:
    ;Cambiamos el modo de pantalla
    ld  a,2     ; La rutina CHGMOD nos obliga a poner en el registro a el modo de pantalla que queremos 
    call CHGMOD ; Mira arriba, pone la explicación, pone screen 2 y sprite de 16 sin apliar
    
    ld a,(RG1SAV) ;en esta dirección está el valor del el 1 registro de soo escritura del VDP, en el se controla el tamaño de los sprites
    or 00000010b ;vamos a obligarle a que trabaje con los sprites de 16 pixeles
    ;or 00000011b
    ;and 11111110b ; lo he comentado porque no quiero grande
    ld b,a 
    ld c,1
    call WRTVDP ;rutina que es escribe el valor en el reistro de solo escritura indicado previamente
    ret

screen2x16:
    ; 	pone los colores de tinta , fondo y borde
	ld      hl,FORCLR
	ld      [hl],15; le poneos el 15 en tinta que es el blanco
	inc     hl
	ld      [hl],1 ; le metemos 1 en fondo que es el negro
	inc		hl
	ld		[hl],1 ;en borde también el negro
	call    CHGCLR

;click off	
	xor	a		
	ld	[CLIKSW],a
		
;- screen 2
	ld a,2
	call CHGMOD;rutina de la bios que cambia el modo de screen

	;sprites no ampliados de 16x16
	ld b,0xe2
	ld c,1
	call 0x47

	ret

;************************************Final de inicializar_modo_pantalla********************

;Este include lleva la rutina de descompresion de los archivos a VRAM
;Hay que meterle previamente en el reg. hl la dirección de la RAM y en DE la VRAM
depack_VRAM:
    include "src/PL_VRAM_Depack.asm"

include "src/bios.asm"

;Este include lleva dentro la rutina depack para descomprimir archivos en ram
;la rutina unpack necesita que le metas previamente en el reg. hl la dirección de lso datos que uieres descomprimir y en de la direccion de la RAM
include "src/unpack.asm"

include "src/controles.asm"
include "src/coche.asm"
include "src/enemigo.asm"
;include "src/enemigo2.asm"
include "src/contenedor.asm"
include "src/numeros.asm"




;Esta es la pantalla con la foto
tiles_screen1:
    incbin "src/screens/screen1/screen1.bin.chr.plet5"
color_screen1:
    incbin "src/screens/screen1/screen1.bin.clr.plet5"
map_screen1: 
    incbin "src/screens/screen1/screen1.bin.plet5"



;Esta es la pantalla en el que el coche aparece abajo a la izquiera y pone comisaría
tiles_screen2:
    incbin "src/screens/screen2/screen2.bin.chr.plet5"
color_screen2:
    incbin "src/screens/screen2/screen2.bin.clr.plet5"
map_screen2: 
    incbin "src/screens/screen2/screen2.bin.plet5"



;En las siguientes pantallas utilizaremos los tiles de la pantalla 2
map_screen3: 
    incbin "src/screens/screen3/screen3.bin.plet5"
map_screen4: 
    incbin "src/screens/screen4/screen4.bin.plet5"
map_screen5: 
    incbin "src/screens/screen5/screen5.bin.plet5"




;**********************************************/
;*********VARIABLES DEL SISTEMA****************/
;**********************************************/


screen_actual: db 0


buffer_de_colsiones: ds 768 ;es el mapa o tabla de nombres de VRAM copiada aquí

	include	"src/PT3_player.s"					;replayer de PT3
SONG:
	incbin "src/cancion2.pt3"			;musica de ejemplo




FINAL:











