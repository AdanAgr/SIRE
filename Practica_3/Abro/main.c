#include <stdio.h>
#include <stdbool.h>
#include "abro_ABRO.h" // Incluir el archivo de cabecera generado
int main() {
  // Variables de entrada y salida
  _boolean A = false; // Se˜nal A
  _boolean B = false; // Se˜nal B
  _boolean R = false; // Reset
  _boolean O = false; // Salida O
  abro_ABRO_ctx_type abro_ctx; // Contexto del nodo ABRO
  abro_ABRO_ctx_reset(&abro_ctx); // Inicializar el contexto
// Simulaci´on de interacci´on con el usuario
while (true) {
// Solicitar al usuario qu´e se˜nal desea enviar
char opcion;
printf("¿Qu´e se˜nal desea enviar? (a = A, b = B, c = A y B, r = Reset, s = salir): ");
scanf(" %c", &opcion);
    if (opcion == 'a') { // Activar la se˜nal A
    A = true;
    B = false; // Reiniciar la se˜nal B
    R = false; // Reiniciar el reset
    } else if (opcion == 'b') { // Activar la se˜nal B
    B = true;
    A = false; // Reiniciar la se˜nal A
    R = false; // Reiniciar el reset
    } else if (opcion == 'c') {
    A = true;
    B = true;
    R = false;
    }else if (opcion == 'r') { // Activar el reset
    R = true;
    A = false; // Reiniciar la se˜nal A
    B = false; // Reiniciar la se˜nal B
    } else if (opcion == 's') { // Salir del programa
    break;
    } else {
    printf("Opci´on no v´alida.\n");
    continue;
}
// Llamar a la funci´on principal de ABRO
abro_ABRO_step(A, B, R, &O, &abro_ctx);
// Mostrar el estado de la salida
if (O) {
printf("¡Salida O activada!\n");
} else {
printf("Salida O desactivada.\n");
}
}
return 0;
}
