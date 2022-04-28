#include<stdio.h>

int longitudDeCadena (char[]);
int convertirAEquivalenteNumerico (char[]);
int convertirAMayuscula (char[]);
int eliminarCaracter (char[], char);
int concatenarCadenas (char[], char[]);
int agregarCaracterEnPosicion (char[], char, int);


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
    printf("\n\nFuncion convertir en mayusculas.\n Inserte la cadena de caracteres: ");
    scanf("%s", palabra3);
    convertirAMayuscula(palabra3);

    char palabra4[30+1];
    printf("\n\nFuncion quitar caracter.\n Inserte la cadena de caracteres: ");
    scanf("%s", palabra4);
    char basura = getchar ();
    char sacarEsteCaracter;
    printf("Ahora inserte el caracter que quiera eliminar: ");
    sacarEsteCaracter = getchar(); 
    eliminarCaracter(palabra4, sacarEsteCaracter);

    char palabra5[30+1];
printf("\n\nFuncion concatenar cadenas.\n Inserte la cadena de caracteres: ");
    scanf("%s", palabra5);
    printf("\nInserte la cadena a concatenar: ");
    char palabraAConcatenar[30+1];
    scanf("%s", palabraAConcatenar);
    concatenarCadenas(palabra5, palabraAConcatenar);

    char palabra6[30+1];
    printf("\n\nFuncion insertar caracter. \nInserte la cadena de caracteres: ");
    scanf("%s", palabra6);
    char basura2 = getchar();
    char caracterAAgregar;
    printf("Inserte el caracter que desea agregar: ");
    caracterAAgregar = getchar();
    printf("Inserte la posicion en la que desea agregarlo: ");
    int posicion;
    scanf("%i", &posicion);
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



 int obtenerMultiplicador(int cantCaract){
    int ret = 1;
    for(int i = 1;i < cantCaract;i++){
        ret *= 10;
    }
    return ret;
}
int charToInt(char numero){
    return numero-48;
}
int stringToInt(char numero[]){
    int ret = 0;
    int multiplicador = obtenerMultiplicador(longitudDeCadena(numero));
    for(int i = 0;i<longitudDeCadena(numero);i++){
        ret += charToInt(numero[i])*multiplicador;
        multiplicador /= 10;
    }
    return ret;
}
 
  /*  for(int i=0; cadena[i] != '\0'; i++){
        printf("%d ", cadena[i]); // si se usa %d en printf, nos estamos refiriendo a un valor numerico, por lo que si le pasamos un caracter, tomará su valor en la tabla ASCII
    }

    return 0;
}*/

convertirAMayuscula (char cadena[]){

    for(int i=0; cadena[i] != '\0'; i++){
        if (cadena[i]>=97 && cadena[i]<=122){
            printf("%c", cadena[i]-32); // se le resta 32 porque esa es la distancia entre una letra minuscula y su mayuscula en la tabla ASCII
        } else {
            printf("%c", cadena[i]);
        }
    }

    return 0;
}

eliminarCaracter (char cadena[], char caracterEliminado){

    for(int i=0; cadena[i] != '\0'; i++){
        
        if (cadena[i] == caracterEliminado){ //cuando llega a la posición del caracter eliminado, agrega 1 al indice "i", haciendo que evite mostrar por pantalla esa posición en la cadena
          i++;
          if(cadena[i] == '\0'){
              printf("%c", cadena[i]);
              break;
          }
          }
               
        if (cadena[i]!='\0')
        {
             printf("%c", cadena[i]);
        }
       
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

char aux [longitudDeCadena(cadena)+1];

for(int i = 0; i < posicionCarAgr-1; i++){

    aux [i] = cadena [i];
   

}

aux [posicionCarAgr-1] = caracterAgregado;

for (int j = (posicionCarAgr-1); cadena[j] != '\0' ; j++){

    aux[j+1] = cadena [j];
    

}
for(int t = 0; aux[t] != '\0';t++){
printf("%c", aux[t] );
}

return 0;

}


