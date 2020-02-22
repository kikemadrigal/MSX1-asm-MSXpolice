sprites_enemigo:

    ; 4-Enemigo mirando frente
    db 000h,001h,001h,007h,00Bh,00Bh,00Bh,00Bh
    db 003h,003h,002h,006h,00Ch,008h,000h,000h
    db 000h,080h,080h,0E0h,0D0h,0D0h,0D0h,0D0h
    db 0C0h,0C0h,040h,040h,040h,040h,040h,060h
    ; 5-Enemigo  frente a ndando
    db 000h,001h,001h,007h,00Bh,00Bh,00Bh,00Bh
    db 003h,003h,002h,002h,002h,002h,002h,006h
    db 000h,080h,080h,0E0h,0D0h,0D0h,0D0h,0D0h
    db 0C0h,0C0h,040h,060h,020h,020h,030h,000h
    ; 6-Enemigo mirando izquierd
    db 000h,001h,001h,003h,003h,003h,003h,003h
    db 001h,001h,001h,001h,001h,001h,001h,003h
    db 000h,080h,080h,0C0h,0C0h,0C0h,0C0h,0C0h
    db 080h,080h,080h,080h,080h,080h,080h,080h
    ; 7-Enemigo izquierd andando
    db 000h,001h,001h,003h,003h,003h,003h,003h
    db 001h,001h,001h,001h,001h,001h,001h,003h
    db 000h,080h,080h,0C0h,0C0h,0C0h,0C0h,0C0h
    db 080h,080h,080h,080h,040h,020h,010h,000h
    ; 8-Enemigo mirando derecha
    db 000h,001h,001h,003h,003h,003h,003h,003h
    db 001h,001h,001h,001h,001h,001h,001h,001h
    db 000h,080h,080h,0C0h,0C0h,0C0h,0C0h,0C0h
    db 080h,080h,080h,080h,080h,080h,080h,0C0h
    ; 9-Enemigo  derecha andanoo
    db 000h,001h,001h,003h,003h,003h,003h,003h
    db 001h,001h,001h,001h,002h,004h,008h,000h
    db 000h,080h,080h,0C0h,0C0h,0C0h,0C0h,0C0h
    db 080h,080h,080h,080h,080h,080h,080h,0C0h
    ; 10-Enemigo mirando atras
    db 000h,001h,001h,007h,007h,007h,007h,007h
    db 003h,003h,002h,003h,001h,001h,000h,000h
    db 000h,080h,080h,0E0h,0F0h,0D0h,0D0h,0C0h
    db 0C0h,0C0h,040h,060h,020h,0B0h,090h,000h
    ; 11-Enemigo atras andando
    db 000h,001h,001h,007h,007h,007h,007h,007h
    db 003h,003h,002h,002h,004h,005h,00Dh,001h
    db 000h,080h,080h,0E0h,0E0h,0D0h,0D0h,0D0h
    db 0C0h,0C0h,040h,040h,0C0h,080h,000h,000h


    

atributos_enemigo_sprite: ds 4,0
;atributos_enemigo_sprite_posicion_y DB $90 ;posicion y
;atributos_enemigo_sprite_posicion_x DB $90 ;posicion x
;atributos_enemigo_sprite_numero_sprite DB $08 ;numero de patron
;atributos_enemigo_sprite_color DB $08 ; aqui se defien el color y el early clock (que es para desparecer el sprite),el último byte el 1000 1000 (1000 para que aparezca) y 1000 (el color rojo)=1000+1000=88 en decimal
;---------------------VRAM UPDATE-----------------------------

volcar_sprite_enemigo_atributos_en_VRAM:
    ld hl, atributos_enemigo_sprite ; la rutina LDIRVM necesita haber cargado previamente la dirección de inicio de la RAM, para saber porqué he puesto 0000 fíjate este dibujo https://sites.google.com/site/multivac7/files-images/TMS9918_VRAMmap_G2_300dpi.png ,así es como está formado el VDP en screen 2
    ld de, #1b00+4; le ponemos el +16 porque los primeros 4 bytes son los del coche        
    ld bc,4; bytes
    call  LDIRVM ; Mira arriba, pone la explicación

    ret

;---------------------------controles enemigo----------------------

inicializacion_variables_enemeigo_sprite:
    ;Son los sprites del 4 al 11, 4 frente, 5 frente andando, 6 izquierda, 7 izquierda andando
    ;8 derecha, 9 derecha andando, 10 abajo, 11 abajo andando (recuerda que hay que multiplicar por 4)
    ld a,50
    ld (enemigo_posicion_x),a
    ld a,100
    ld (enemigo_posicion_y),a
    ld a, 11*4 ; el sprite es el 11
    ld (enemigo_patron),a
    ld a, 4 ;le ponemos el color rojo
    ld (enemigo_color),a
    ld a,0 ;esto es para cambiar de sprite si anda
    ld (enemigo_esta_andado_o_no),a
    ld a,1 ;esto es para cambiar de sprite si anda
    ld (enemigo_esta_andado_o_no),a
    ld a,2 ;le metemos la ruta 2
    ld (enemigo_ruta),a
    ret

actualiza_atributos_de_enemigo_sprite:
    ld ix,atributos_enemigo_sprite
    ;para el sprite 1
    ld a, (enemigo_posicion_y)
    ld (ix),a
    ld a,(enemigo_posicion_x)
    ld (ix+1),a
    ld a, (enemigo_patron)
    ld (ix+2),a
    ld a, (enemigo_color)
    ld (ix+3),a
    ret
poner_enemigo_punto_inicial:
    call inicializacion_variables_enemeigo_sprite
    call actualiza_atributos_de_enemigo_sprite
    ret
poner_a_cero_enmeigo_posicion_x
    xor a
    ld (enemigo_posicion_x),a
    ret
actualiza_posicion_enemigo
    ld a,(enemigo_ruta)
    cp 0
        jp z,mover_enemigo_derecha
    cp 1
        jp z,mover_enemigo_derecha
    cp 2
        jp z,mover_enemigo_izquierda
    cp 3
        jp z,mover_enemigo_abajo
    cp 4
        jp z,mover_enemigo_arriba
    ret

seleccion_ruta_uno_enemigo:
    ld a, 1
    ld (enemigo_ruta),a
    ld a, 20
    ld (enemigo_posicion_x),a
    ld a, 0
    ld (enemigo_posicion_y),a
  
    ret

seleccion_ruta_dos_enemigo:
    ld a, 120
    ld (enemigo_posicion_x),a
    ld a, 90
    ld (enemigo_posicion_y),a
    ld a,2
    ld (enemigo_ruta),a
    ret
seleccion_ruta_tres_enemigo:
    ld a, 3
    ld (enemigo_ruta),a
    ld a, 100
    ld (enemigo_posicion_x),a
    ld a, 0
    ld (enemigo_posicion_y),a
    ret
seleccion_ruta_cuatro_enemigo:
    ld a, 4
    ld (enemigo_ruta),a
    ld a, 20
    ld (enemigo_posicion_x),a
    ld a, 250
    ld (enemigo_posicion_y),a
    ret

;***************************
;******Derecha**************
;***************************


;***Controlando retraso******
mover_enemigo_derecha:
    ;Son los sprites del 4 al 11, 4 frente, 5 frente andando, 6 izquierda, 7 izquierda andando
    ;8 derecha, 9 derecha andando, 10 abajo, 11 abajo andando (recuerda que hay que multiplicar por 4)
    ld a,(contador_retardo)
    cp 10 ; si el retardo es 10 actialuzamos la pisición
    jp z,actuliazar_posicion_derecha
    inc a
    ld (contador_retardo),a; si el retardo no es 10 incrementamos en 1 su valor
    ret
actuliazar_posicion_derecha:
    ld a,(enemigo_posicion_x); obetenemos el valor actual de la posicion x
    inc a; incrementamos en 1 el valor
    ld (enemigo_posicion_x), a ; se lo metemos al atributo

    ;*****Controlando animanción
    ;ld a,8*4 ;le ponemos el patron mirando hacia la derecha que es el 3
    ;ld (enemigo_patron),a;ponemos al patrón 1
    ld a,(enemigo_esta_andado_o_no)
    cp 1 ;si esta andado
    jp z, izquierda_no_andando ;le ponemos que no ande
    jp izquierda_andando ;sino está andado le ponemos que ande

    ;****controlando retraso*****
    xor a
    ld (contador_retardo),a ;como el retardo ha sido 20 lo ponemos a 0
    ret
derecha_andando:
    ld a,8*4 ;le ponemos el patron mirando hacia la derecha que es el 3
    ld (enemigo_patron),a
    ld a,1
    ld (enemigo_esta_andado_o_no),a
    ret
derecha_no_andando:
    ld a,9*4 ;le ponemos el patron mirando hacia la derecha que es el 3
    ld (enemigo_patron),a
    xor a
    ld (enemigo_esta_andado_o_no),a
    ret









;***************************
;******izquierda**************
;***************************


;*******Controlando retraso*********    
mover_enemigo_izquierda:
    ld a,(contador_retardo)
    cp 20 ; si el retardo es 10 actialuzamos la pisición
    jp z,actualizar_enemigo_a_la_izquierda
    inc a
    ld (contador_retardo),a; si el retardo no es 10 incrementamos en 1 su valor
    ret
actualizar_enemigo_a_la_izquierda:
    ld a,(enemigo_posicion_x); obetenemos el valor actual de la posicion x
    sub 3 ; incrementamos en 1 el valor
    ld (enemigo_posicion_x), a ; se lo metemos al atributo

    ;****conrtolando animanción**
    ;ld a,6*4 ;le ponemos el patron mirando hacia la izquierda que es el 2
    ;ld (enemigo_patron),a;le cambiamos al patrón 4 (12 en headecimal)
    ld a,(enemigo_esta_andado_o_no)
    cp 1 ;si esta andado
    call z, izquierda_no_andando ;le ponemos que no ande
    call izquierda_andando ;sino está andado le ponemos que ande

    ;****contrlando retraso*****
    xor a
    ld (contador_retardo),a ;como el retardo ha sido 10 lo ponemos a 0
    ret
izquierda_andando:
    ld a,6*4 ;le ponemos el patron mirando hacia la derecha que es el 3
    ld (enemigo_patron),a
    ld a,1
    ld (enemigo_esta_andado_o_no),a
    ret
izquierda_no_andando:
    ld a,7*4 ;le ponemos el patron mirando hacia la derecha que es el 3
    ld (enemigo_patron),a
    xor a
    ld (enemigo_esta_andado_o_no),a
    ret





;***************************
;******Arriba**************
;***************************


;*****Controlando el retraso*************
mover_enemigo_arriba:
    ld a,(contador_retardo)
    cp 10 ; si el retardo es 10 actialuzamos la pisición
    jp z,actualizar_enemigo_arriba
    inc a
    ld (contador_retardo),a; si el retardo no es 10 incrementamos en 1 su valor
    ret


actualizar_enemigo_arriba:
    ld a,(enemigo_posicion_y); obetenemos el valor actual de la posicion y
    sub 1 ; incrementamos en 1 el valor
    ld (enemigo_posicion_y), a ; se lo metemos al atributo
    ;miramos si esta adando para cambiarle el sprite
    ld a,(enemigo_esta_andado_o_no)

    ;*******Controlando el sprite*****
    ;ld a,4*4 ;le ponemos el patron mirando hacia la derecha que es el 3
    ;ld (enemigo_patron),a;ponemos al patrón 1
    ;miramos si esta adando para cambiarle el sprite
    ld a,(enemigo_esta_andado_o_no)
    cp 1 ;si esta andado
    jp z, abajo_no_andando ;le ponemos que no ande
    jp abajo_andando ;sino está andado le ponemos que ande

    ;******restraso animación*******
    xor a
    ld (contador_retardo),a ;como el retardo ha sido 10 lo ponemos a 0
    ret
arriba_andando:
    ld a,4*4 ;le ponemos el patron mirando hacia la derecha que es el 3
    ld (enemigo_patron),a
    ld a,1
    ld (enemigo_esta_andado_o_no),a
    ret
arriba_no_andando:
    ld a,5*4 ;le ponemos el patron mirando hacia la derecha que es el 3
    ld (enemigo_patron),a
    xor a
    ld (enemigo_esta_andado_o_no),a
    ret










;***************************
;******Abajo**************
;***************************

;*****Controlando retraso****
mover_enemigo_abajo:
    ld a,(contador_retardo)
    cp 10 ; si el retardo es 10 actialuzamos la pisición
    jp z,actualizar_enemigo_abajo
    inc a
    ld (contador_retardo),a; si el retardo no es 10 incrementamos en 1 su valor
    ret

actualizar_enemigo_abajo:
    ld a,(enemigo_posicion_y); obetenemos el valor actual de la posicion y
    add 1 ; incrementamos en 1 el valor
    ld (enemigo_posicion_y), a ; se lo metemos al atributo

    ;***Controlando animación***
    ;miramos si esta adando para cambiarle el sprite
    ld a,(enemigo_esta_andado_o_no)
    cp 1 ;si esta andado
    jp z, abajo_no_andando ;le ponemos que no ande
    jp abajo_andando ;sino está andado le ponemos que ande

    ;***Controlando retraso****
    xor a
    ld (contador_retardo),a ;como el retardo ha sido 10 lo ponemos a 0
  
    ret
abajo_andando:
    ld a,10*4 ;le ponemos el patron mirando hacia la derecha que es el 3
    ld (enemigo_patron),a
    ld a,1
    ld (enemigo_esta_andado_o_no),a
    ret
abajo_no_andando:
    ld a,11*4 ;le ponemos el patron mirando hacia la derecha que es el 3
    ld (enemigo_patron),a
    xor a
    ld (enemigo_esta_andado_o_no),a
    ret


incrementar_enemigo_posicion_x:
    call mover_enemigo_derecha
    ret
decrementa_enemigo_posicion_x:
    call mover_enemigo_izquierda
    ret
incrementar_enemigo_posicion_y:
    call mover_enemigo_abajo
    ret
decrementa_enemigo_posicion_y:
    call mover_enemigo_arriba
    ret





;Definición de variables
enemigo_posicion_y: db 0
enemigo_posicion_x: db 0
enemigo_esta_andado_o_no: db 0

enemigo_patron: db 0
enemigo_color: db 0

enemigo_ruta: db 1

paso_permitido: db 0;0 no permitido, 1 si permitido
contador_retardo: db 0
retardo: db 10

