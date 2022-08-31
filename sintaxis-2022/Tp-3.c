#include<stdio.h>
#include<stdlib.h>
#include<stdbool.h>

void automataIdentificadores(char[]);
void automataCaracteres(char[]);
void automataOperadores(char[]);
//void automataPalabrasReservadas(char[]);
void automataConstantes(char[]);
void automataAsignacion(char[]);
void automataComentarios(char[]);
bool esMinuscula(char);
bool esMayuscula(char);
bool esNumero(char);

int main(){

    bool continuar = true;

    while(continuar){
        printf("Indique la categoria lexica: \n\n");

        printf("1. Identificadores\n");
        printf("2. Caracteres de Puntuacion\n");
        printf("3. Operadores\n");
        printf("4. Palabras reservadas\n");
        printf("5. Constantes\n");
        printf("6. Asignacion\n");
        printf("7. Comentarios\n");
        printf("0. Salir del Programa\n\n");
        
        printf("Su respuesta: \n");
        int respuesta = 6;

        system("PAUSE");

        if(respuesta == 0){
            continuar = false;
        }

        if(respuesta == 1){
            system("cls");
            char palabra[50];
            printf("Ingrese la palabra: ");
            scanf("%s", palabra);
            automataIdentificadores(palabra);
            system("cls");
        }

        if(respuesta == 2){
            system("cls");
            char palabra1[50];
            printf("Ingrese la palabra: ");
            scanf("%s", palabra1);
            automataCaracteres(palabra1);
            system("cls");
        }

        if(respuesta == 3){
            system("cls");
            char palabra2[50];
            printf("Ingrese la palabra: ");
            scanf("%s", palabra2);
            automataOperadores(palabra2);
            system("cls");
        }

        if(respuesta == 4){
            //system("cls");
            char palabra3[50];
            printf("Ingrese la palabra: ");
            scanf("%s", palabra3);
          //  automataPalabrasReservadas(palabra3);
            //system("cls");
        }

        if(respuesta == 5){
            system("cls");
            char palabra4[50];
            printf("Ingrese la palabra: ");
            scanf("%s", palabra4);
            automataConstantes(palabra4);
            system("cls");
        }

        if(respuesta == 6){
            system("cls");
            char palabra5[50];
            printf("Ingrese la palabra: ");
            scanf("%s", palabra5);
            automataAsignacion(palabra5);
            system("cls");
        }
        
        if(respuesta == 7){
            system("cls");
            char palabra6[50];
            printf("Ingrese la palabra: ");
            scanf("%s", palabra6);
            automataComentarios(palabra6);
            system("cls");
        }
    }

    return 0;
}

void automataIdentificadores(char palabra[]){
    int inicial = 0;
    int final = 1;
    int actual = inicial;

    int contador = 0;
    bool continuar = true;

    if(esMayuscula(palabra[0]) || esNumero(palabra[0]) || palabra[0] == '0'){
        continuar = false;
    }

    while(continuar){

        if(palabra[contador] == '\0'){
            continuar = false;
            break;
        }

        if(esMinuscula(palabra[contador])){
            actual = 1;
        }

        if(esMayuscula(palabra[contador])){
            actual = 1;
        }

        if(esNumero(palabra[contador]) || palabra[0] == '0'){
            actual = 1;
        }

        contador++;
    }

    if(actual == final){
        printf("\nAcepta la palabra\n");
    } else {
        printf("\nNo acepta la palabra\n");
    }

    system("PAUSE");
}

void automataCaracteres(char palabra[]){
    int inicial = 0;
    int noFinal = 2;
    int noFinal1 = 3;
    int final = 1;
    int final1 = 4;
    int final2 = 5;
    int actual = inicial;

    int contador = 0;
    bool continuar = true;

    while(continuar){

        if(palabra[contador] == '\0'){
            continuar = false;
            break;
        }

        if(palabra[contador] == '('){
            actual = noFinal;
        }

        if(palabra[contador] == ')' && actual == noFinal){
            actual = final2;
            continuar = false;
            break;
        }

        if(palabra[contador] == ','){
            actual = final;
            continuar = false;
            break;
        }

        if(palabra[contador] == '.'){
            actual = noFinal1;
        }

        if(palabra[contador] == '-' && actual == noFinal1){
            actual = final1;
            continuar = false;
            break;
        }

        contador++;
    }

    if(actual == final || actual == final1 || actual == final2){
        printf("\nAcepta la palabra.\n");
    } else {
        printf("\nNo acepta la palabra.\n");
    }

    system("PAUSE");
}

void automataOperadores(char palabra[]){
    int inicial = 0;
    int final1 = 1;
    int final2 = 2;
    int final3 = 3;
    int final4 = 4;
    int actual = inicial;

    int contador = 0;
    bool continuar = true;

    while(continuar){

        if(palabra[contador] == '\0'){
            continuar = false;
            break;
        }

        if(palabra[contador] == '+'){
            actual = final1;
        }

        if(palabra[contador] == '*'){
            actual = final2;
        }

        if(palabra[contador] == '/'){
            actual = final3;
        }

        if(palabra[contador] == '-'){
            actual = final4;
        }

        contador++;
    }

    if(actual == final1 || actual == final2 || actual == final3 || actual == final4){
        printf("\nAcepta la palabra.\n");
    }else{
        printf("\nNo acepta la palabra.\n");
    }

    system("PAUSE");
}

//void automataPalabraReservada(char palabra[]){
   
//}

void automataConstantes(char palabra[]){
    int inicial = 0;
    int final1 = 1;
    int final2 = 2;
    int final3 = 3;
    int actual = inicial;

    int contador = 0;
    int continuar = true;

    while(continuar){

        if(palabra[contador] == '\0'){
            continuar = false;
            break;
        }

        if((esNumero(palabra[contador]) || palabra[contador] == '0') && actual == final3){
            actual =  final3;
            contador++;
            continue;
        }

        if(esNumero(palabra[contador])){
            actual = final2;
        }

        if(palabra[contador] == '0' && actual == inicial){
            actual = final2;
        }

        if((palabra[contador] == '0' || esNumero(palabra[contador])) && actual == final2){
            continuar = false;
            break;
        }

        if(palabra[contador] == '.' && (actual == final1 || actual == final2)){
            actual = final3;
        }

        contador++;
    }

    if(actual == final1 || (actual == final2 && palabra == "0") || actual == final3){
        printf("\nAcepta la palabra.");
    }else{
        printf("\nNo acepta la palabra.");
    }

    system("PAUSE");
}

void automataAsignacion(char palabra[]){
    int inicial = 0;
    int final = 2;
    int noFinal = 1;
    int actual = inicial;

    int contador = 0;
    bool continuar = true;

    while(continuar){

        if(palabra[contador] == '\0'){
            continuar = false;
            break;
        }

        if(palabra[contador] == '=' && actual == inicial){
            actual = noFinal;
        }

        if(palabra[contador] == '=' && actual == noFinal){
            continuar = false;
            break;
        }

        if(palabra[contador] == '>' && actual == noFinal){
            actual = final;
        }

        contador++;
    }

    if(actual == final){
        printf("\nAcepta la palabra.\n");
    }else{
        printf("\nNo acepta la palabra.\n");
    }

    system("PAUSE");
}

void automataComentarios(char palabra[]){
    int inicial = 0;
    int noFinal = 1;
    int final = 2;
    int actual = inicial;

    int contador = 0;
    bool continuar = true;

    while(continuar){

        if(palabra[contador] == '\0'){
            continuar = false;
            break;
        }

        if(palabra[contador] == ':' && actual == inicial){
            actual == noFinal;
        }

        if(palabra[contador] == '^' && actual == noFinal){
            actual = final;
        }

        if(actual == final && (esMayuscula(palabra[contador]) || esMinuscula(palabra[contador]) || esNumero(palabra[contador]) || palabra[contador] == '0')){
            actual = final;
        }

        contador++;
    }

    if(actual == final){
        printf("\nAcepta la palabra.\n");
    }else {
        printf("\nNo acepta la palabra.\n");
    }


    system("PAUSE");
}

bool esMinuscula(char letra){

    if(letra == 'a' || letra == 'b' || letra == 'c' || letra == 'd' || letra == 'e' || letra == 'f' || letra == 'g' || letra == 'h' || letra == 'i' || letra == 'j' || letra == 'k' || letra == 'l' || letra == 'm' || letra == 'n' || letra == 'o' || letra == 'p' || letra == 'q' || letra == 'r' || letra == 's' || letra == 't' || letra == 'u' || letra == 'v' || letra == 'w' || letra == 'x' || letra == 'y' || letra == 'z'){
        return true;
    } 

    return false;
}

bool esMayuscula(char letra){

    if(letra == 'A' || letra == 'B' || letra == 'C' || letra == 'D' || letra == 'E' || letra == 'F' || letra == 'G' || letra == 'H' || letra == 'I' || letra == 'J' || letra == 'K' || letra == 'L' || letra == 'M' || letra == 'N' || letra == 'O' || letra == 'P' || letra == 'Q' || letra == 'R' || letra == 'S' || letra == 'T' || letra == 'U' || letra == 'V' || letra == 'W' || letra == 'X' || letra == 'Y' || letra == 'Z'){
        return true;
    }

    return false;
}

bool esNumero(char numero){

    if(numero == '1' || numero == '2' || numero == '3' || numero == '4' || numero == '5' || numero == '6' || numero == '7' || numero == '8' || numero == '9'){
        return true;
    }

    return false;
}
