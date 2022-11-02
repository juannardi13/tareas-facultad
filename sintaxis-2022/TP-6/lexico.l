%{
#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include <string.h>
FILE *yyin;
int yyerror(void);
%}

/*seccion de opciones*/
/*Indica a Flex que lea solo un fichero de entrada*/
%option noyywrap
/*Permite obtener el numero de linea*/
%option yylineno

/*Tokens*/

MIN [a-z]
MAY [A-Z]
LETRA   [A-Z] | [a-z]
NUM [0-9]
DIG [a-z] | [A-Z] | [0-9]
/*CARACTERES DE PUNTUACION*/
PAREN_IZQ  ["("]
PAREN_DER  [")"]
COMA [","]
LLAVE_IZQ ["{"]
LLAVE_DER ["}"]
FIN_DE_SENT ".-"

ASIGNACION "=>"

/*OPERADORES*/
OP_SUMA [\+]
OP_RESTA [\-]
OP_MULT [\*]
OP_DIV [/]

/*PALABRAS RESERVADAS*/
STARTEGG "startEgg"
HATCHEGG "hatchEgg"
POLL "poll"
CORN "corn"
CACKLE "cackle"

PALABRA_RESERVADA {STARTEGG}|{HATCHEGG}|{POLL}|{CORN}|{CACKLE}
IDENTIFICADOR {MIN}({MIN}|{MAY}|{NUM})*
CONSTANTE (0|[1-9][0-9]*)(\.[0-9]*)?


%%
{STARTEGG}          {printf("\nPalabra reservada: STARTEGG (%s)", yytext);}
{HATCHEGG}          {printf("\nPalabra reservada: HATCHEGG (%s)", yytext);}
{POLL}              {printf("\nPalabra reservada: POLL (%s)", yytext);}
{CORN}              {printf("\nPalabra reservada: CORN (%s)", yytext);}    
{CACKLE}            {printf("\nPalabra reservada: CACKLE (%s)", yytext);}
{IDENTIFICADOR}     {printf("\nIDENTIFICADOR (%s)", yytext);}
{PAREN_IZQ}         {printf("\nPAREN_IZQ (%s)", yytext);}
{PAREN_DER}         {printf("\nPAREN_DER (%s)", yytext);}
{COMA}              {printf("\nCOMA (%s)", yytext);}
{LLAVE_IZQ}         {printf("\nLLAVE_IZQ (%s)", yytext);}
{LLAVE_DER}         {printf("\nLLAVE_DER (%s)", yytext);}
{FIN_DE_SENT}       {printf("\nFIN_DE_SENT (%s)", yytext);}
{ASIGNACION}        {printf("\nASIGNACION (%s)", yytext);}
{OP_SUMA}           {printf("\nOP_SUMA (%s)", yytext);}
{OP_RESTA}          {printf("\nOP_RESTA (%s)", yytext);}
{OP_MULT}           {printf("\nOP_MULT (%s)", yytext);}
{OP_DIV}            {printf("\nOP_DIV (%s)", yytext);}
{CONSTANTE}         {printf("\nCONSTANTE (%s)", yytext);}

" "
"\n"
"\t"
.                   yyerror();

%%

int main (int arg, char *argv[]){
    if((yyin = fopen(argv[1], "rt")) == NULL){
        printf("\nNo se puede abrir el archivo: %s\n", argv[1]);
        return 1;
    }
    else{
        printf("\nEl archivo %s se abrio correctamente\n", argv[1]);
        yylex();
    }

    printf("\nFLEX finalizo la lectura del archivo %s \n", argv[1]);
    fclose(yyin);
    return 0;

}


int yyerror(void){
    printf("\nERROR LEXICO :( Escribiste mal: %s \n", yytext);
    exit(1);
}
