; --- Slot 0
sprites_coche:
    ;Son 4 spites=4*32=128 bytes

    ; 0-coche mirando arriba
    db 007h,008h,030h,043h,047h,040h,027h,03Fh
    db 060h,080h,0C0h,0C0h,0C0h,080h,040h,03Fh
    db 0E0h,010h,00Ch,0C2h,0E2h,002h,0E4h,0FCh
    db 006h,001h,003h,003h,003h,001h,002h,0FCh
    ; 1-coche mirando dercha
    db 03Eh,05Dh,081h,080h,080h,080h,080h,080h
    db 080h,080h,080h,080h,080h,081h,05Dh,03Eh
    db 000h,038h,0C4h,084h,082h,0D1h,0D9h,0D9h
    db 0D9h,0D9h,0D1h,082h,084h,0C4h,038h,000h
    ; 2-coche mirando abajo
    db 03Fh,040h,080h,0C0h,0C0h,0C0h,080h,060h
    db 03Fh,027h,040h,047h,043h,030h,008h,007h
    db 0FCh,002h,001h,003h,003h,003h,001h,006h
    db 0FCh,0E4h,002h,0E2h,0C2h,00Ch,010h,0E0h
    ; 3-coche mirando izquierda
    db 000h,01Ch,023h,021h,041h,08Bh,09Bh,09Bh
    db 09Bh,09Bh,08Bh,041h,021h,023h,01Ch,000h
    db 07Ch,0BAh,081h,001h,001h,001h,001h,001h
    db 001h,001h,001h,001h,001h,081h,0BAh,07Ch
    
atributos_coche_sprite: ds 4,0
;atributos_coche_sprite_posicion_y DB $80 ;posicion y
;atributos_coche_sprite_posicion_x DB $55 ;posicion x
;atributos_coche_sprite_posicion_patron DB $00 ;numero de patron, el patrón solo es el 1
;atributos_coche_sprite_posicion_color DB $01 ; aqui se defien el color y el early clock (que es para desparecer el sprite),el último byte el 1000 1000 (1000 para que aparezca) y 1000 (el color rojo)=1000+1000=88 en decimal


;atributos_coche_sprite2: ds 4,0
;atributos_coche_sprite2_posicion_y DB $80 ;posicion y
;atributos_coche_sprite2_posicion_x DB $55 ;posicion x
;atributos_coche_sprite2_posicion_patron DB $04 ;numero de patron, el patrón solo es el 1
;atributos_coche_sprite2_posicion_color DB $05 ; aqui se defien el color y el early clock (que es para desparecer el sprite),el último byte el 1000 1000 (1000 para que aparezca) y 1000 (el color rojo)=1000+1000=88 en decimal




inicializacion_variables_coche_sprite:
    ld a,10 
    ld (posicion_x),a
    ld a,155 
    ld (posicion_y),a
    ld a, 0 ;developer
    ld (patron),a
    ld a, 13 ; el 13 es el color rosa
    ld (color),a

    ;Para sprite 2
    ;ld a,#80
    ;ld (posicion_y),a
    ;ld a,#55
    ;ld (posicion_x),a
    ;ld a, #04
    ;ld (patron_sprite2),a
    ;ld a, #05
    ;ld (color_sprite2),a

    ret
actualiza_atributos_de_coche_sprite:
    ld ix,atributos_coche_sprite
    ;para el sprite 1
    ld a, (posicion_y)
    ld (ix),a
    ld a,(posicion_x)
    ld (ix+1),a
    ld a, (patron)
    ld (ix+2),a
    ld a, (color)
    ld (ix+3),a
    ;para el sprite 2
    ;ld a, (posicion_y)
    ;ld (ix+4),a
    ;ld a,(posicion_x)
    ;ld (ix+5),a
    ;ld a, (patron_sprite2)
    ;ld (ix+6),a
    ;ld a, (color_sprite2)
    ;ld (ix+7),a
    ret

poner_coche_punto_inicial:
    call inicializacion_variables_coche_sprite
    call actualiza_atributos_de_coche_sprite
    ret

sacar_coche_de_la_pantalla:
    ld a,255
    ld (posicion_x),a
    ;ld a,160 ;producción
    ld a,200
    ld (posicion_y),a
    call actualiza_atributos_de_coche_sprite
    call volcar_sprite_coche_atributos_en_VRAM
    ret


poner_coche_en_posicion_screen3:
    ld a,200 ;produución
    ;ld a,200 ;developer
    ld (posicion_x),a
    ld a,180 ;producción
    ;ld a,80
    ld (posicion_y),a
    call actualiza_atributos_de_coche_sprite
    call volcar_sprite_coche_atributos_en_VRAM
    ret
poner_coche_en_posicion_screen4:
    ;ld a,200 ;produución
    ld a,10 ;developer
    ld (posicion_x),a
    ;ld a,180 ;producción
    ld a,65
    ld (posicion_y),a
    call actualiza_atributos_de_coche_sprite
    call volcar_sprite_coche_atributos_en_VRAM
    ret
poner_coche_en_posicion_screen5:
    ;ld a,200 ;produución
    ld a,10 ;developer
    ld (posicion_x),a
    ;ld a,180 ;producción
    ld a,10
    ld (posicion_y),a
    call actualiza_atributos_de_coche_sprite
    call volcar_sprite_coche_atributos_en_VRAM
    ret


;----------------------------VRAM UPDATE------------------------
volcar_sprite_coche_atributos_en_VRAM:
    ld hl, atributos_coche_sprite ; la rutina LDIRVM necesita haber cargado previamente la dirección de inicio de la RAM, para saber porqué he puesto 0000 fíjate este dibujo https://sites.google.com/site/multivac7/files-images/TMS9918_VRAMmap_G2_300dpi.png ,así es como está formado el VDP en screen 2
    ld de, #1b00; la rutina necesita haber cargado previamente con de la dirección de inicio de la VRAM          
    ld bc,4; bytes
    call  LDIRVM ; Mira arriba, pone la explicación

    ret

    
;---------------------CONTROLES (esta sería la forma de hacerlo sin variables)----------------------------
;mover_coche_derecha:
    ;ld a,(ix+1); obetenemos el valor actual de la posicion x
    ;add 3; incrementamos en 1 el valor
    ;ld (ix+1), a ; se lo metemos al atributo
    ;ld (ix+5), a ; atrubuto posicion x del sprite 2
    ;ret
;mover_coche_izquierda:
    ;ld a,(ix+1); obetenemos el valor actual de la posicion x
    ;sub 3 ; incrementamos en 1 el valor
    ;ld (ix+1), a ; se lo metemos al atributo posicion x sprite 1
    ;ld (ix+5), a ; atrubuto posicion x del sprite 2
    ;ret
;mover_coche_arriba:
    ;ld a,(ix); obetenemos el valor actual de la posicion y
    ;sub 3 ; incrementamos en 3 el valor
    ;ld (ix), a ; se lo metemos al atributo  y sprite 1
    ;ld (ix+4), a ; se lo metemos al atributo posicion y sprite 2
    ;ret
;mover_coche_abajo:
    ;ld a,(ix); obetenemos el valor actual de la posicion y
    ;add 3 ; incrementamos en 3 el valor
    ;ld (ix), a ; se lo metemos al atributo posicion y sprite 1
    ;ld (ix+4), a ; se lo metemos al atributo posicion y sprite 2
    ;ret



;---------------------CONTROLES----------------------------
mover_coche_derecha:
    ;comprobamos la colision lateral con un solido
    ld a,(posicion_x)
    ;add 16 ;le añadimos 16 porque estamos trabajando con tiles de 16 pixeles
    add 16
    ld d,a ;en d le metemos la posicionn x
    ld a, (posicion_y)
    ;add 15
    add 15
    ld e, a ; en e le metemos la posicion y
    call dame_el_tile_que_hay_en_x_e_y
    cp 11 ;si es el tile 63 (la losa gris) que es que hemos decido que es un bloque sólido
    jp nc, para_coche ; si al restarlo  es negativo y dará carry, si no hay está bien
    cp 6
    jp nc, incrementar_pantalla

    ld a,(posicion_x); obetenemos el valor actual de la posicion x
    add 1; incrementamos en 1 el valor
    ld (posicion_x), a ; se lo metemos al atributo
    ld a, 4 ; maover a la derecha es el patrón 4
    ld (patron),a
    ret
mover_coche_izquierda:
    ;comprobación choque con solido
    ld a,(posicion_x)
    ;sub 1 ;le añadimos 16 porque estamos trabajando con tiles de 16 pixeles
    sub 1
    ld d,a ;en d le metemos la posicionn x
    ld a, (posicion_y)
    ;add 15
    add 15
    ld e, a ; en e le metemos la posicion y
    call dame_el_tile_que_hay_en_x_e_y
    cp 11 ;si es el tile 63 (la losa gris) que es que hemos decido que es un bloque sólido
    jr nc, para_coche ; si al restarlo  es negativo y dará carry, si no hay está bien
    cp 6
    jp nc, incrementar_pantalla


    ld a,(posicion_x); obetenemos el valor actual de la posicion x
    sub 1 ; incrementamos en 1 el valor
    ld (posicion_x), a ; se lo metemos al atributo posicion x sprite 1
    ld a, 12 ; maover a la izquierda es el patrón 12
    ld (patron),a
    ret
mover_coche_diagonal_arriba_derecha

    ret
mover_coche_diagonal_arriba_izquierda

    ret
mover_coche_diagonal_abajo_derecha

    ret
mover_coche_diagonal_abajo_izquierda

    ret
mover_coche_arriba:
    ld a,(posicion_x)
    ;add 16 ;le añadimos 16 porque estamos trabajando con tiles de 16 pixeles
    ;add 0
    add 0
    ld d,a ;en d le metemos la posicionn x
    ld a, (posicion_y)
    ;add 0
    add 0
    ld e, a ; en e le metemos la posicion y
    call dame_el_tile_que_hay_en_x_e_y
    cp 11 ;si es el tile 63 (la losa gris) que es que hemos decido que es un bloque sólido
    jr nc, para_coche ; si al restarlo  es negativo y dará carry, si no hay está bien
    cp 6
    jp nc, incrementar_pantalla


    ld a,(posicion_y); obetenemos el valor actual de la posicion y
    sub 1 ; incrementamos en 3 el valor
    ld (posicion_y), a ; se lo metemos al atributo  y sprite 1
    ld a, 0 ; maover a la arriba es el patrón 0
    ld (patron),a
    ret
mover_coche_abajo:
    ld a,(posicion_x)
    add 0
    ;add 0;le añadimos 16 porque estamos trabajando con tiles de 16 pixeles
    ld d,a ;en d le metemos la posicionn x
    ld a, (posicion_y)
    ;add 15
    add 17
    ld e, a ; en e le metemos la posicion y
    call dame_el_tile_que_hay_en_x_e_y
    cp 11 ;si es el tile 63 (la losa gris) que es que hemos decido que es un bloque sólido
    jr nc, para_coche ; si al restarlo  es negativo y dará carry, si no hay está bien
    cp 6
    jp nc, incrementar_pantalla

    ld a,(posicion_y); obetenemos el valor actual de la posicion y
    add 1 ; incrementamos en 3 el valor
    ld (posicion_y), a ; se lo metemos al atributo posicion y sprite 1
    ld a, 8 ; maover a la bajo es el patrón 0
    ld (patron),a
    ret
para_coche
    ld a,(posicion_x)
    ld (posicion_x),a
    ld a, (posicion_y)
    ld (posicion_y),a
    ret


dame_el_tile_que_hay_en_x_e_y:
    ;recordad en d tengo la "x" y en e la "y"
    ;Vamos a hacer esta formula (y/8)*32+(x/8)
    ;esta es la parte (y/8)*32
    ;d tiene la posicion de x
    ;e tiene la posicion de y
    ld a,e ;a=y
[3] srl a  ;a=y/8 ;con srl estas dividiendo entre 2, 3 veces sería como dividir entre 8, en realidad corre a la derecha los bits. 
    ld h,0
    ld l,a ;hl=y/8
[5] add hl, hl ;x32,  sumar algo por si mismo es como multiplizarlo por 2, si lo repetivos 5 es como si o multiplixaramos por 32

    ;Esta es la parte +(x/8)
    ld a,d ;a=x
[3] srl a ;a=x/8
    ld d,0
    ld e,a ;de=x/8
    add hl,de ;hl=(y/8)*32+(x/8)

    ld de, buffer_de_colsiones
    add hl,de ;hl=buffer_colisiones + (y/8)*32+(x/8)

    ld a,(hl) ;metemos en a el tile que nos pide
    ret








;Definición de variables
posicion_y: db 0
posicion_x: db 0
incrementa_y: db 0
incrementa_x: db 0
direccion: db 0
paso: db 0
velocidad: db 0
patron: db 0
color: db 0
patron_sprite2: db 0
color_sprite2: db 0

