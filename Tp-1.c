#include<stdio.h>

int longitudDeCadena (char[]);
int obtenerMultiplicador(int);
int charToInt(char);
int stringToInt(char[]);
int convertirAEquivalenteNumerico(char[]);
char* convertirAMayuscula(char[]);
char* eliminarCaracter(char[], char);
char* concatenarCadenas(char[], char[]);
char* agregarCaracterEnPosicion(char[], char, int);


int main (){

    char palabra[30+1];
    printf("Funcion longitud de la palabra. \nInserte la cadena de caracteres: ");
    scanf("%s", palabra);
    printf("\nLa longitud de la cadena es de: %d", longitudDeCadena(palabra));

    char palabra2[30+1];
    printf("\n\nFuncion cadena a entero.\nInserte la cadena de digitos: ");
    scanf("%s", palabra2);
    printf("el valor int es %d", stringToInt(palabra2));

    char palabra3[30+1];
    printf("\n\nFuncion convertir en mayusculas.\nInserte la cadena de caracteres: ");
    scanf("%s", palabra3);
    printf("%s", convertirAMayuscula(palabra3));

    char palabra4[30+1];
    printf("\n\nFuncion quitar caracter.\nInserte la cadena de caracteres: ");
    scanf("%s", palabra4);
    char basura = getchar ();
    char sacarEsteCaracter;
    printf("Ahora inserte el caracter que quiera eliminar: ");
    sacarEsteCaracter = getchar(); 
    printf("%s", eliminarCaracter(palabra4, sacarEsteCaracter));

    char palabra5[30+1];
    printf("\n\nFuncion concatenar cadenas.\nInserte la cadena de caracteres: ");
    scanf("%s", palabra5);
    printf("\nInserte la cadena a concatenar: ");
    char palabraAConcatenar[30+1];
    scanf("%s", palabraAConcatenar);
    printf("%s", concatenarCadenas(palabra5, palabraAConcatenar));

    char palabra6[30+1];
    printf("\n\nFuncion insertar caracter.\nInserte la cadena de caracteres: ");
    scanf("%s", palabra6);
    char basura2 = getchar();
    char caracterAAgregar;
    printf("Inserte el caracter que desea agregar: ");
    caracterAAgregar = getchar();
    printf("Inserte la posicion en la que desea agregarlo: ");
    int posicion;
    scanf("%i", &posicion);
    printf("%s", agregarCaracterEnPosicion(palabra6, caracterAAgregar, posicion));

    return 0;
}

longitudDeCadena (char cadena[]){
    int contadorDeLetras = 0;
    int i; 

    for(i=0; cadena[i] != '\0'; i++){
        contadorDeLetras++;
    }

    return contadorDeLetras;
};

obtenerMultiplicador(int cantCaract){
    int ret = 1;
    for(int i = 1;i < cantCaract;i++){
        ret *= 10;
    }
    return ret;
}

charToInt(char numero){
    return numero-48;
}

stringToInt(char numero[]){
    int ret = 0;
    int multiplicador = obtenerMultiplicador(longitudDeCadena(numero));
    for(int i = 0;i<longitudDeCadena(numero);i++){
        ret += charToInt(numero[i])*multiplicador;
        multiplicador /= 10;
    }
    return ret;
}

char* convertirAMayuscula (char cadena[]){

    char aux[30];
    int i;

    for(i=0; cadena[i] != '\0'; i++){
        if (cadena[i]>=97 && cadena[i]<=122){
            aux[i] = (cadena[i]-32);
        } else {
            aux[i] = cadena[i];
        } 
        
    }
    
    for(int t=0; t < i; t++){
        cadena[t] = aux[t];
    }
    
    return cadena;
}

char* eliminarCaracter (char cadena[], char caracterEliminado){

    char aux[30];
    int i=0;
    int j=0;

    for(i=0; cadena[i] != '\0'; i++){
        
        if (cadena[i] == caracterEliminado){ 
            continue;

            if(cadena[i] == '\0'){
                 aux[j] = cadena[i];
                break;
            }
        }

        if (cadena[i] != '\0'){
             aux[j] = cadena[i];
             j++;
        }
       
    }

    for(int t=0; t < j; t++){
        cadena[t] = aux[t];

        if((t+1) == j){
            cadena[t+1] = '\0';
        }
    }

    return cadena;
}

char* concatenarCadenas (char cadena1[], char cadena2[]){

    char aux[longitudDeCadena(cadena1) + longitudDeCadena(cadena2) + 1];
    int i;

    for (i=0; cadena1[i] != '\0'; i++){
        aux[i] = cadena1[i];
    }

    for (int j=0; ; j++){
        aux[i] = cadena2[j];
        i++;  

        if (cadena2[j] == '\0'){
            aux[i] = '\0';
            break;
        }      
    }

    for(int t=0; t <= i; t++){
        cadena1[t] = aux[t];
    }

    return cadena1;
}

char* agregarCaracterEnPosicion (char cadena[], char caracterAgregado, int posicionCarAgr){

    char aux [longitudDeCadena(cadena)+1];
    int i;

    for(i = 0; i < posicionCarAgr-1; i++){
        aux [i] = cadena [i];
    }   

    aux [posicionCarAgr-1] = caracterAgregado;

    for (i = (posicionCarAgr-1); cadena[i] != '\0' ; i++){
        aux[i+1] = cadena [i];

        if(cadena[i+1] == '\0'){
            aux[i+2] = '\0';
            break;
        }
    }

    for(int j=0; j < longitudDeCadena(aux); j++){
        cadena[j] = aux[j];

        if(aux[j+1] == '\0'){
            cadena[j+1] = '\0';
        }
    }

    return cadena;
}