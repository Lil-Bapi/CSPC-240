// Author name: Quan Khong
// Author email: kquan59@csu.fullerton.edu
// Course and section:  CPSC240-3
// Today’s date: Mar 20, 2024


#include "stdio.h"

extern double manager();

int main() {
    
    printf("Welcome to Fantastic Reciprocals\n");
    double result = manager();
    
    printf("\nThe main function received this number %1.5lf, and will keep it for a while.\n", result);
    printf("A zero will be returned to the OS. Bye reciprocal\n");
    return 0;
}