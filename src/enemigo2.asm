sprites_enemigo2:

    ; 4-Enemigo2 mirando frente
    db 000h,001h,001h,007h,00Bh,00Bh,00Bh,00Bh
    db 003h,003h,002h,006h,00Ch,008h,000h,000h
    db 000h,080h,080h,0E0h,0D0h,0D0h,0D0h,0D0h
    db 0C0h,0C0h,040h,040h,040h,040h,040h,060h
    ; 5-Enemigo2  frente a ndando
    db 000h,001h,001h,007h,00Bh,00Bh,00Bh,00Bh
    db 003h,003h,002h,002h,002h,002h,002h,006h
    db 000h,080h,080h,0E0h,0D0h,0D0h,0D0h,0D0h
    db 0C0h,0C0h,040h,060h,020h,020h,030h,000h
    ; 6-Enemigo2 mirando izquierd
    db 000h,001h,001h,003h,003h,003h,003h,003h
    db 001h,001h,001h,001h,001h,001h,001h,003h
    db 000h,080h,080h,0C0h,0C0h,0C0h,0C0h,0C0h
    db 080h,080h,080h,080h,080h,080h,080h,080h
    ; 7-Enemigo2 izquierd andando
    db 000h,001h,001h,003h,003h,003h,003h,003h
    db 001h,001h,001h,001h,001h,001h,001h,003h
    db 000h,080h,080h,0C0h,0C0h,0C0h,0C0h,0C0h
    db 080h,080h,080h,080h,040h,020h,010h,000h
    ; 8-Enemigo2 mirando derecha
    db 000h,001h,001h,003h,003h,003h,003h,003h
    db 001h,001h,001h,001h,001h,001h,001h,001h
    db 000h,080h,080h,0C0h,0C0h,0C0h,0C0h,0C0h
    db 080h,080h,080h,080h,080h,080h,080h,0C0h
    ; 9-Enemigo2  derecha andanoo
    db 000h,001h,001h,003h,003h,003h,003h,003h
    db 001h,001h,001h,001h,002h,004h,008h,000h
    db 000h,080h,080h,0C0h,0C0h,0C0h,0C0h,0C0h
    db 080h,080h,080h,080h,080h,080h,080h,0C0h
    ; 10-Enemigo2 mirando atras
    db 000h,001h,001h,007h,007h,007h,007h,007h
    db 003h,003h,002h,003h,001h,001h,000h,000h
    db 000h,080h,080h,0E0h,0F0h,0D0h,0D0h,0C0h
    db 0C0h,0C0h,040h,060h,020h,0B0h,090h,000h
    ; 11-Enemigo2 atras andando
    db 000h,001h,001h,007h,007h,007h,007h,007h
    db 003h,003h,002h,002h,004h,005h,00Dh,001h
    db 000h,080h,080h,0E0h,0E0h,0D0h,0D0h,0D0h
    db 0C0h,0C0h,040h,040h,0C0h,080h,000h,000h


    

atributos_enemigo2_sprite: ds 4,0
;atributos_enemigo_sprite_posicion_y DB $90 ;posicion y
;atributos_enemigo_sprite_posicion_x DB $90 ;posicion x
;atributos_enemigo_sprite_numero_sprite DB $08 ;numero de patron
;atributos_enemigo_sprite_color DB $08 ; aqui se defien el color y el early clock (que es para desparecer el sprite),el último byte el 1000 1000 (1000 para que aparezca) y 1000 (el color rojo)=1000+1000=88 en decimal
;---------------------VRAM UPDATE-----------------------------

volcar_sprite_enemigo2_atributos_en_VRAM:
    ld hl, atributos_enemigo2_sprite ; la rutina LDIRVM necesita haber cargado previamente la dirección de inicio de la RAM, para saber porqué he puesto 0000 fíjate este dibujo https://sites.google.com/site/multivac7/files-images/TMS9918_VRAMmap_G2_300dpi.png ,así es como está formado el VDP en screen 2
    ld de, #1b00+4; le ponemos el +16 porque los primeros 4 bytes son los del coche        
    ld bc,4; bytes
    call  LDIRVM ; Mira arriba, pone la explicación

    ret

;---------------------------controles enemigo2----------------------

inicializacion_variables_enemeigo_sprite:
    ;Son los sprites del 4 al 11, 4 frente, 5 frente andando, 6 izquierda, 7 izquierda andando
    ;8 derecha, 9 derecha andando, 10 abajo, 11 abajo andando (recuerda que hay que multiplicar por 4)
    ld a,60
    ld (enemigo2_posicion_x),a
    ld a,150
    ld (enemigo2_posicion_y),a
    ld a, 11*4 ; el sprite es el 11
    ld (enemigo2_patron),a
    ld a, 8 ;le ponemos el color rojo
    ld (enemigo2_color),a
    ld a,0 ;esto es para cambiar de sprite si anda
    ld (enemigo2_esta_andado_o_no),a
    ld a,1 ;esto es para cambiar de sprite si anda
    ld (enemigo2_esta_andado_o_no),a
    ld a,2 ;le metemos la ruta 2
    ld (enemigo2_ruta),a
    ret

actualiza_atributos_de_enemigo2_sprite:
    ld ix,atributos_enemigo2_sprite
    ;para el sprite 1
    ld a, (enemigo2_posicion_y)
    ld (ix),a
    ld a,(enemigo2_posicion_x)
    ld (ix+1),a
    ld a, (enemigo2_patron)
    ld (ix+2),a
    ld a, (enemigo2_color)
    ld (ix+3),a
    ret
poner_enemigo2_punto_inicial:
    call inicializacion_variables_enemeigo2_sprite
    call actualiza_atributos_de_enemigo2_sprite
    ret
poner_a_cero_enmeigo2_posicion_x
    xor a
    ld (enemigo2_posicion_x),a
    ret
actualiza_posicion_enemigo2
    ld a,(enemigo2_ruta)
    cp 0
        jp z,mover_enemigo2_derecha
    cp 1
        jp z,mover_enemigo2_derecha
    cp 2
        jp z,mover_enemigo2_izquierda
    cp 3
        jp z,mover_enemigo2_abajo
    cp 4
        jp z,mover_enemigo2_arriba
    ret

seleccion_ruta_uno_enemigo2:
    ld a, 1
    ld (enemigo2_ruta),a
    ld a, 20
    ld (enemigo2_posicion_x),a
    ld a, 0
    ld (enemigo2_posicion_y),a
  
    ret

seleccion_ruta_dos_enemigo2:
    ld a, 120
    ld (enemigo2_posicion_x),a
    ld a, 50
    ld (enemigo2_posicion_y),a
    ld a,2
    ld (enemigo2_ruta),a
    ret
seleccion_ruta_tres_enemigo:
    ld a, 3
    ld (enemigo2_ruta),a
    ld a, 100
    ld (enemigo2_posicion_x),a
    ld a, 0
    ld (enemigo2_posicion_y),a
    ret
seleccion_ruta_cuatro_enemigo2:
    ld a, 4
    ld (enemigo2_ruta),a
    ld a, 20
    ld (enemigo2_posicion_x),a
    ld a, 250
    ld (enemigo2_posicion_y),a
    ret

mover_enemigo2_derecha:
    ;Son los sprites del 4 al 11, 4 frente, 5 frente andando, 6 izquierda, 7 izquierda andando
    ;8 derecha, 9 derecha andando, 10 abajo, 11 abajo andando (recuerda que hay que multiplicar por 4)
    ld a,(enemigo2_posicion_x); obetenemos el valor actual de la posicion x
    add 1; incrementamos en 1 el valor
    ld (enemigo2_posicion_x), a ; se lo metemos al atributo
    ld a,8*4 ;le ponemos el patron mirando hacia la derecha que es el 3
    ld (enemigo2_patron),a;ponemos al patrón 1
    ret
mover_enemigo2_izquierda:
    ld a,(enemigo2_posicion_x); obetenemos el valor actual de la posicion x
    sub 3 ; incrementamos en 1 el valor
    ld (enemigo2_posicion_x), a ; se lo metemos al atributo
    ld a,6*4 ;le ponemos el patron mirando hacia la izquierda que es el 2
    ld (enemigo2_patron),a;le cambiamos al patrón 4 (12 en headecimal)
    ret
mover_enemigo2_arriba:
    ld a,(enemigo2_posicion_y); obetenemos el valor actual de la posicion y
    sub 1 ; incrementamos en 1 el valor
    ld (enemigo2_posicion_y), a ; se lo metemos al atributo
    ;miramos si esta adando para cambiarle el sprite
    ld a,(enemigo2_esta_andado_o_no)
    
    ld a,4*4 ;le ponemos el patron mirando hacia la derecha que es el 3
    ld (enemigo2_patron),a;ponemos al patrón 1
    
    ret
mover_enemigo_abajo:
    ld a,(enemigo2_posicion_y); obetenemos el valor actual de la posicion y
    add 1 ; incrementamos en 1 el valor
    ld (enemigo2_posicion_y), a ; se lo metemos al atributo
    ;miramos si esta adando para cambiarle el sprite
    ld a,(enemigo2_esta_andado_o_no)
    cp 1 ;si esta andado
    jp z, abajo_no_andando ;le ponemos que no ande
    jp abajo_andando ;sino está andado le ponemos que ande
    ret
abajo_andando:
    ld a,10*4 ;le ponemos el patron mirando hacia la derecha que es el 3
    ld (enemigo2_patron),a
    ld a,1
    ld (enemigo2_esta_andado_o_no),a
    ret
abajo_no_andando:
    ld a,11*4 ;le ponemos el patron mirando hacia la derecha que es el 3
    ld (enemigo2_patron),a
    xor a
    ld (enemigo2_esta_andado_o_no),a
    ret


incrementar_enemigo2_posicion_x:
    call mover_enemigo_derecha
    ret
decrementa_enemigo2_posicion_x:
    call mover_enemigo_izquierda
    ret
incrementar_enemigo2_posicion_y:
    call mover_enemigo_abajo
    ret
decrementa_enemigo2_posicion_y:
    call mover_enemigo_arriba
    ret





;Definición de variables
enemigo2_posicion_y: db 0
enemigo2_posicion_x: db 0
enemigo_esta_andado_o_no: db 0

enemigo2_patron: db 0
enemigo2_color: db 0

enemigo2_ruta: db 1



