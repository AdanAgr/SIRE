#include <stdio.h>
#include "horas_HORAS.h"

int main()
{
    horas_HORAS_ctx_type horas_ctx;
    horas_HORAS_ctx_reset(&horas_ctx);
    int h = 0, m = 0, s = 0, salida;

    while (1) {
        char option;

        printf("¿Qué parámetro quieres cambiar? (h = hora, m = minutos, s = segundos, q = salir): ");
        scanf(" %c", &option);

        if (option == 'h') {
            printf("Introduce la nueva hora: ");
            scanf("%d", &h);
        } else if (option == 'm') {
            printf("Introduce los nuevos minutos: ");
            scanf("%d", &m);
        } else if (option == 's') {
            printf("Introduce los nuevos segundos: ");
            scanf("%d", &s);
        } else if (option == 'q') {
            break; 
        } else {
            printf("Opción no válida. Intente de nuevo.");
            continue;
        }

        // Llamar a la función de Lustre
        horas_HORAS_step(h, m, s, &salida, &horas_ctx);

        // Mostrar resultado
        printf("Tiempo transcurrido desde el mediodía: %d segundos", salida);
    }

    return 0;
}
