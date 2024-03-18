#include "stdio.h"

extern double manager();

int main() {
   
    printf("Welcome to Arrays of floating point numbers.\n");
    printf("Bought to you by Quan Khong\n\n");

    double answer = manager();
    printf("\nMain recieved %1.18lf, and will keep it for future use.\n", answer);
    printf("Main will return 0 to the operating system. Bye.\n");
    return 0;
}