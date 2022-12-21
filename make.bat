@echo off
echo .
echo ***********************************************
echo ***@Authors: MSX Spain 2023***************
echo ***********************************************
echo .

rem variables globales
Set nombrePrograma=main

rem Compilando el archivo .bin generado por sjasm
start tools\sjasm\sjasm.exe -s src/%nombrePrograma%.asm



rem Creando el .dsk, para ver los comandos abrir archivo DISKMGR.chm
rem start /wait tools\Disk-Manager\DISKMGR.exe -A -F -C %nombrePrograma%.dsk resources\AUTOEXEC.BAS
rem start /wait tools\Disk-Manager\DISKMGR.exe -A -F -C %nombrePrograma%.dsk %nombrePrograma%.bin

rem Creando una carpeta para mover nuestros archivos
If not exist .\objects md .\objects
If not exist .\dsk md .\dsk

rem copiamos el archivo generado a la carpeta dsk
move %nombrePrograma%.bin dsk\%nombrePrograma%.bin
rem Nos llevamos el .lst a objects, archivo que nos muestra el ensamblado línea a línea
rem copiando el autoexec.bas
copy /y  resources\AUTOEXEC.BAS dsk\AUTOEXEC.BAS

rem Esta es mi ruta donde está copiado el openMSX en este proyecto, no necesitas tenerlo en tu pc
Set rutaOpenMSX=tools\emulators\openmsx\openmsx.exe
Set rutaScriptOpenMSX=tools\emulators\openmsx\emul_start_config.txt
Set procesoOpenMSX=openmsx.exe
rem tasklist muestra una lista de procesos que se está ejecutando en el equipo, por favor pon tasklist /? en el cmd
rem find busca una cadena ed texto en uno o más archivos, por favor pon find /? en el cmd
tasklist | find /i "%procesoOpenMSX%">nul  && (echo %procesoOpenMSX% openMSX ya esta arrancado) || start %rutaOpenMSX% -script %rutaScriptOpenMSX% 

rem start tools\bluemsx\blueMSX.exe -diskA ../../%nombrePrograma%.dsk





rem Moviendo archivos a la carpeta oibjects, por favor pon move /? o @move /? en el cmd


move src\%nombrePrograma%.sym ../objects 
move src\%nombrePrograma%.lst ./objects 


rem Creando el rom
rem start /wait tools\dsk2rom\dsk2rom.exe %nombrePrograma%.dsk %nombrePrograma%.rom

rem Creando el .cas 
rem start /wait tools\mcp\mcp.exe -a %nombrePrograma%.cas cargad.asc %nombrePrograma%.bin

rem Creando el wav, recuerda poner en el basic run"cas:"
rem start /wait tools\mcp\mcp.exe -e %nombrePrograma%.cas %nombrePrograma%.wav

