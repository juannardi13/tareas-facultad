%{
	#include<stdio.h>
	#include<conio.h>
	void yyerror(char *);
        int yylex();
%}

 
%token POLL 
%token CACKLE
%token CORN
%token CONSTANTE
%token STARTEGG
%token HATCHEGG
%token FIN_DE_SENT
%token ASIGNACION
%token IDENTIFICADOR

%% 

programa : STARTEGG listaSentencias HATCHEGG
	      ;
listaSentencias : sentencia listaSentencias
                | sentencia 
                ;
sentencia : POLL expresion FIN_DE_SENT
          | IDENTIFICADOR ASIGNACION expresion FIN_DE_SENT
          | CORN '('identificadores')'
          | CACKLE '('identificadores')'
          ;
identificadores : IDENTIFICADOR
                | identificadores',' IDENTIFICADOR
                ;
expresion : termino
            | termino '+' expresion 
	        | termino '-' expresion  
	        ;
termino : valor
        | valor '*' termino
        | valor '/' termino
        ;
valor : CONSTANTE
        | '('expresion')'
        | '-''('expresion')'

%%

int main(void)
{
	
	if(yyparse()==0)
		printf("Compilacion exitosa\n");
	return 0;
}

void yyerror(char * s)
{
	puts(s);

}
