#include <stdio.h>
#include <stdbool.h>

// protótipos
int squareRoot(int, int);
void loop();

int main()
{
    printf("Programa de Raíz Quadrada - Newton-Raphson\n\nDesenvolvedores: Alex Fraga, Bernardo Fioreze, Rafael Roth, Rodrigo Sandler\n\n----------------------------------------------------------------------------");
    loop();
    printf("Encerrando Programa..."); // Fim
    return 0;
}

void loop()
{
    int x = 0, i = 0, res = 0;

    while (true)
    {
        printf("\n\nPara abortar a execução a qualquer momento, insira um numero negativo!!!\n\nPara calcular sqrt(x,i), informe o que pede:\n\nDigite o 'x':\n\n");
        scanf("%d", &x);

        if (x < 0) // se x for negativo finaliza execução
            return;

        printf("\nDigite o 'i':\n\n");
        scanf("%d", &i);

        if (i < 0) // se i for negativo finaliza execução
            return;

        res = squareRoot(x, i); // guarda sqrt(x, i) em res
        printf("-----------------------------\n");
        printf("| sqrt(%d,%d) = %d\n", x, i, res);
        printf("-----------------------------\n");
    }
}

int squareRoot(int x, int i)
{
    if (i == 0)
        return 1;

    i--;
    return (squareRoot(x, i) + (x / squareRoot(x, i))) / 2;
}