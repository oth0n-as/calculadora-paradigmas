#include <stdio.h>
#include <stdlib.h>

int main(void)
{
    unsigned short input = 0;
    double n1 = 0;
    double n2 = 0;

        
    while(1)
    {
        printf("\nCALCULADORA\n\nSelecione uma das opcoes:\n");
        printf("1. soma \n2. subtracao \n3. multiplicacao \n4. divisao \n\n");
        
        input = 0;
        scanf("%hu", &input);
        if(input > 4) break;

        printf("\nescolha os dois numeros:\n");
        if(input % 2 == 0) printf("(Atencao: a ordem dos fatores importa)\n\n");
        
        n1 = 0;
        n2 = 0;
        scanf("%lf", &n1);
        scanf("%lf", &n2);

        switch(input) 
        {
            case 1:
                printf("\n%.2lf + %.2lf = %.2lf\n\n", n1, n2, n1+n2);
                break;
            
            case 2:
                printf("\n%.2lf - %.2lf = %.2lf\n\n", n1, n2, n1-n2);
                break;

            case 3:
                printf("\n%.2lf * %.2lf = %.2lf\n\n", n1, n2, n1*n2);
                break;

            case 4:
                printf("\n%.2lf / %.2lf = %.2lf\n\n", n1, n2, n1/n2);
                break;
        }

        getchar();
        getchar();
        system("clear");
    }

    system("clear");

    return 0;
}
