sprites_numeros:
    ; El 1
    DB $00,$01,$03,$06,$0C,$00,$00,$00
    DB $00,$00,$00,$00,$07,$00,$00,$00
    DB $00,$C0,$C0,$C0,$C0,$C0,$C0,$C0
    DB $C0,$C0,$C0,$C0,$F8,$00,$00,$00

    
atributos_numeros_sprite: ds 4,0


inicializacion_variables_numeros_sprite:
    ;Para sprite 1
    ld a,#10
    ld (numeros_posicion_y),a
    ld a,#10
    ld (numeros_posicion_x),a
    ld a, #18
    ld (numeros_patron),a
    ld a, #08
    ld (numeros_color),a


    ret
actualiza_atributos_de_numeros_sprite:
    ld ix,atributos_numeros_sprite
    ;para el sprite 1
    ld a, (numeros_posicion_y)
    ld (ix),a
    ld a,(numeros_posicion_x)
    ld (ix+1),a
    ld a, (numeros_patron)
    ld (ix+2),a
    ld a, (numeros_color)
    ld (ix+3),a
    ret
    


;----------------------------VRAM UPDATE------------------------
volcar_sprite_numeros_atributos_en_VRAM:
    ld hl, atributos_numeros_sprite ; la rutina LDIRVM necesita haber cargado previamente la dirección de inicio de la RAM, para saber porqué he puesto 0000 fíjate este dibujo https://sites.google.com/site/multivac7/files-images/TMS9918_VRAMmap_G2_300dpi.png ,así es como está formado el VDP en screen 2
    ld de, #1b00+12; la rutina necesita haber cargado previamente con de la dirección de inicio de la VRAM          
    ld bc,4; bytes
    call  LDIRVM ; Mira arriba, pone la explicación

    ret


;Definición de variables
numeros_posicion_y: db 0
numeros_posicion_x: db 0
numeros_patron: db 0
numeros_color: db 0
