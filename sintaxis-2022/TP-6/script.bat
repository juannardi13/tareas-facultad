@echo off
:: LEXICO
c:\GnuWin32\bin\flex lexico.l
echo "Se creo un archivo lex.yy.c"
pause
c:\MinGW\bin\gcc.exe lex.yy.c -o programitaLCompilado.exe
echo "Se creo un archivo programitaLCompilado.exe"
pause
programitaLCompilado.exe programitaPollex.txt
echo "Se ejecuto el analizador lexico sobre el archivo programitaPollex.txt"
pause

::SINTACTICO
c:\GnuWin32\bin\bison -dy sintactico.y
echo "Se creo un archivo y.tab.c"
pause
c:\MinGW\bin\gcc.exe y.tab.c -o programitaSCompilado.exe
echo "Se creo un archivo programitaSCompilado.exe"
pause

::ELIMINAR ARCHIVOS CREADOS
echo "Se eliminaran los archivos generados en todo el proceso"
del lex.yy.c
del y.tab.h
del y.tab.c
del a.exe
del programitaLCompilado.exe
del programitaSCompilado.exe
pause