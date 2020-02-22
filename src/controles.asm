teclas_o_p_q_a:
    call CHGET ;espera a que se pulse una tecla, cuando se pulsa la almacena en el registro a del z80

    cp 'p'
    jp z, mover_coche_derecha
    cp 'o'
    jp z, mover_coche_izquierda
    cp 'q'
    jp z, mover_coche_arriba
    cp 'a'
    jp z, mover_coche_abajo
    cp 't'
    jp z, poner_coche_punto_inicial

    ret

cursores:
    ld a,0
    call GTSTCK
    
    cp 1
    jp z, mover_coche_arriba
    cp 2
    jp z, mover_coche_diagonal_arriba_derecha
    cp 3
    jp z, mover_coche_derecha
    cp 4
    jp z, mover_coche_diagonal_abajo_derecha
    cp 5
    jp z, mover_coche_abajo
    cp 6
    jp z, mover_coche_diagonal_abajo_izquierda
    cp 7
    jp z, mover_coche_izquierda
    cp 8
    jp z, mover_coche_diagonal_arriba_izquierda

    ret

disparo_presionado_o_no:
    ld a,0
    call GTTRIG ; pone en el registro a el resultado
    cp #99
    

    ret
