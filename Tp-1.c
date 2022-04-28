#include<stdio.h>

int longitudDeCadena (char[]);
int convertirAEquivalenteNumerico (char[]);
int convertirAMayuscula (char[]);
int eliminarCaracter (char[], char);
int concatenarCadenas (char[], char[]);
int agregarCaracterEnPosicion (char[], char, int);

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

    char palabra4[30+1];
    printf("\n\nInserte la cadena de caracteres: ");
    scanf("%s", palabra4);
    char sacarEsteCaracter = 'c';
   // printf("Ahora inserte el caracter que quiera eliminar: ");
   // scanf("%c", sacarEsteCaracter);
    eliminarCaracter(palabra4, sacarEsteCaracter);

    char palabra5[30+1];
    printf("\n\nInserte la cadena de caracteres: ");
    scanf("%s", palabra5);
    printf("\nInserte la cadena a concatenar: ");
    char palabraAConcatenar[30+1];
    scanf("%s", palabraAConcatenar);
    concatenarCadenas(palabra5, palabraAConcatenar);

    char palabra6[30+1];
    printf("\n\nInserte la cadena de caracteres: ");
    scanf("%s", palabra6);
    char caracterAAgregar = 'a';
    // printf("Inserte el caracter que desea agregar: ");
    // scanf("%c", caracterAAgregar);
    int posicion;
    printf("Inserte la posicion en la que desea agregarlo: ");
    scanf("%d", posicion);
    agregarCaracterEnPosicion(palabra6, caracterAAgregar, posicion);

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
        printf("%d ", cadena[i]); // si se usa %d en printf, nos estamos refiriendo a un valor numerico, por lo que si le pasamos un caracter, tomará su valor en la tabla ASCII
    }

    return 0;
}

convertirAMayuscula (char cadena[]){

    for(int i=0; cadena[i] != '\0'; i++){
        printf("%c", cadena[i]-32); // se le resta 32 porque esa es la distancia entre una letra minuscula y su mayuscula en la tabla ASCII
    }

    return 0;
}

eliminarCaracter (char cadena[], char caracterEliminado){

    for(int i=0; cadena[i] != '\0'; i++){
        
        if (cadena[i] == caracterEliminado){ //cuando llega a la posición del caracter eliminado, agrega 1 al indice "i", haciendo que evite mostrar por pantalla esa posición en la cadena
          i++;
        }
        
        printf("%c", cadena[i]);
    }

    return 0;
}

concatenarCadenas (char cadena1[], char cadena2[]){

    for (int i=0; cadena1[i] != '\0'; i++){
        printf("%c", cadena1[i]);
    }

    for (int j=0; cadena2[j] != '\0'; j++){
        printf("%c", cadena2[j]);        
    }

    return 0;
}

agregarCaracterEnPosicion (char cadena[], char caracterAgregado, int posicionCarAgr){

    for (int i=0; cadena[i] != '\0';){

        if (i == (posicionCarAgr --)){ //tomamos que la posición 1 sea la primera letra de la cadena, cuando i llegue a la posición deseada se imprime por pantalla el caracter agregado
            printf("%c", caracterAgregado);
        } else {
            printf("%c", cadena[i]); //mientras la posición no sea la que deseamos, la cadena se imprime normalmente
            i++;
        }

    }

    return 0;
}