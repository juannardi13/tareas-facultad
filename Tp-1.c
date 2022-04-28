#include<stdio.h>

int longitudDeCadena (char[]);
int convertirAEquivalenteNumerico (char[]);
int convertirAMayuscula (char[]);

int main (){

    char palabra[30+1];
    printf("Inserte la cadena de caracteres: ");
    scanf("%s", palabra);
    printf("\nLa longitud de la cadena es de: %d", longitudDeCadena(palabra));

    char palabra2[30+1];
    printf("\n\nInserte la cadena de caracteres: ");
    scanf("%s", palabra2);
    convertirAEquivalenteNumerico(palabra2);

    char palabra3[30+1];
    printf("\n\nInserte la cadena de caracteres: ");
    scanf("%s", palabra3);
    convertirAMayuscula(palabra3);

    return 0;
}

longitudDeCadena (char cadena[]){
    int contadorDeLetras = 0;
    int i; // i será un índice que recorrerá toda la cadena de caractéres hasta hallar aquel que sea \0

    for(i=0; cadena[i] != '\0'; i++){
        contadorDeLetras++;
    }

    return contadorDeLetras;
};

convertirAEquivalenteNumerico (char cadena[]){

    for(int i=0; cadena[i] != '\0'; i++){
        printf("%d ", cadena[i]);
    }

    return 0;
}

convertirAMayuscula (char cadena[]){

    for(int i=0; cadena[i] != '\0'; i++){
        printf("%c", cadena[i]-32);
    }

    return 0;
}