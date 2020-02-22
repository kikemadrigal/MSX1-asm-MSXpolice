sprites_contedor:
    ; 12-contenedor llamas 1
    db 080h,0D8h,0DAh,0DBh,059h,05Fh,07Fh,03Fh
    db 07Fh,07Fh,07Fh,07Fh,07Fh,03Fh,018h,018h
    db 006h,01Eh,05Ch,0DEh,0CEh,0CEh,0FEh,0FCh
    db 0FEh,0FEh,0FEh,0FEh,0FEh,0FCh,018h,018h
    ; 13-contenedor llamas 2
    db 000h,000h,000h,000h,000h,000h,000h,03Fh
    db 07Fh,07Fh,07Fh,07Fh,07Fh,03Fh,018h,018h
    db 000h,000h,000h,000h,000h,000h,000h,0FCh
    db 0FEh,0FEh,0FEh,0FEh,0FEh,0FCh,018h,018h

    
atributos_contendor_sprite: ds 4,0
;----------------------------VRAM UPDATE------------------------
volcar_sprite_contenedor_atributos_en_VRAM:
    ld hl, atributos_contendor_sprite ; la rutina LDIRVM necesita haber cargado previamente la dirección de inicio de la RAM, para saber porqué he puesto 0000 fíjate este dibujo https://sites.google.com/site/multivac7/files-images/TMS9918_VRAMmap_G2_300dpi.png ,así es como está formado el VDP en screen 2
    ld de, #1b00+8; Es el 3 patron de atributos, los 1 4 bytes el coche, los 2 4 bytes enemigos        
    ld bc,4; bytes
    call  LDIRVM ; Mira arriba, pone la explicación

    ret

inicializacion_variables_contendor_sprite:
    ;Para sprite 1
    ld a,1
    ld (contenedor_posicion_y),a
    ld a,40
    ld (contenedor_posicion_x),a
    ld a, 12*4
    ld (contenedor_patron),a
    ld a, 8
    ld (contenedor_color),a
    ld a,0
    ld (contendor_andando_o_no),a
    ret
actualiza_atributos_de_contenedor_sprite:
    ld ix,atributos_contendor_sprite
    ;para el sprite 1
    ld a, (contenedor_posicion_y)
    ld (ix),a
    ld a,(contenedor_posicion_x)
    ld (ix+1),a
    ld a, (contenedor_patron)
    ld (ix+2),a
    ld a, (contenedor_color)
    ld (ix+3),a
    ret
incrementa_posicion_x_contedor:
    ld a,(contenedor_posicion_x); obetenemos el valor actual de la posicion x
    add 1; incrementamos en 1 el valor
    ld (contenedor_posicion_x), a ; se lo metemos al atributo
   
    ;Los sprites son el 12 y el 13
    ;miramos si esta adando para cambiarle el sprite
    ld a,(contendor_andando_o_no)
    cp 1 ;si esta andado
    jp z, contendor_abajo_andando ;le ponemos que no ande
    jp contendor_abajo_no_andando ;sino está andado le ponemos que ande
    ret
contendor_abajo_andando:
    ld a,12*4 ;le ponemos el patron mirando hacia la derecha que es el 3
    ld (contenedor_patron),a
    xor a
    ld (contendor_andando_o_no),a
    ld a, 11; color amarillo
    ld (contenedor_color),a
    ret
contendor_abajo_no_andando:
    ld a,13*4 ;le ponemos el patron mirando hacia la derecha que es el 3
    ld (contenedor_patron),a
    ld a,1
    ld (contendor_andando_o_no),a
    ld a, 8;color rojo
    ld (contenedor_color),a
    ret
seleccion_ruta_uno_contenedor:
    ld a, 100
    ld (contenedor_posicion_x),a
    ld a, 150
    ld (contenedor_posicion_y),a
    ret
seleccion_ruta_dos_contenedor:
    ld a, 100
    ld (contenedor_posicion_x),a
    ld a, 20
    ld (contenedor_posicion_y),a
    ret
seleccion_ruta_tres_contenedor:
    ld a, 100
    ld (contenedor_posicion_x),a
    ld a, 0
    ld (contenedor_posicion_y),a
    ret
seleccion_ruta_cuatro_contenedor:
    ld a, 100
    ld (contenedor_posicion_x),a
    ld a, 10
    ld (contenedor_posicion_y),a
    ret




;Definición de variables
contenedor_posicion_y: db 0
contenedor_posicion_x: db 0
contenedor_patron: db 0
contenedor_color: db 0 ;aparillo es el 11 y rojo el 8
contendor_andando_o_no: db 0