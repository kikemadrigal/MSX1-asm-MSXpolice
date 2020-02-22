rem Hay que poner "make screen3" 
set filename=%1
echo "Convirtiendo a pt3 archivo csv: " %filename%
cd ../../tools/Csv2bin
start /wait java -jar Csv2bin.jar ../../src/screens/%filename%.csv ../../src/screens/%filename%.bin
cd ../../src/screens

echo "Comprimiendo .bin"
cd ../../tools/pletter
start /wait pletter.exe ../../src/screens/%filename%.bin 
cd ../../src/screens
