#!/bin/bash
#este archivo es un script creado con el lenguaje shell script o bash
#escribe el valor linux o windows
so="windows"
# Compilando el archivo .bin generado por sjasm
if [ $so == "windows" ]
then
    tools/sjasm/sjasm.exe -s src/main.asm
elif [ $so == "linux" ]
then
    tools/sjasm/sjasm -s src/main.asm
fi

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
if [ $so == "windows" ]
then
    start tools/emulators/openmsx/openmsx -script tools/emulators/openmsx/emul_start_config.txt  
elif [ $so= = "linux" ]
then
    openmsx -script tools/emulators/openmsx/emul_start_config.txt 
fi


#Quitando archivos innecesarios
mv src/main.sym objects 
mv src/main.lst objects 