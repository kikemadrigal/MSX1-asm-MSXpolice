#!/bin/bash

# Compilando el archivo .bin generado por sjasm
tools/sjasm/sjasm -s src/main.asm

# Creando una carpeta para mover nuestros archivos
if [ -d "dsk" ]
then
   echo "El directorio dsk existe"
else
    mkdir dsk
fi

if [ -d "objects" ]
then
   echo "El directorio dsk existe"
else
    mkdir objects
fi

# copiamos el archivo generado a la carpeta dsk
mv main.bin dsk
# copiando el autoexec.bas
cp resources/AUTOEXEC.BAS dsk/

#Abriendo emulador
start openmsx-script tools/emulators/openmsx/emul_start_config.txt

#Quitando archivos innecesarios
mv src/main.sym objects 
mv src/main.lst objects 