#include <stdio.h>
#include <iostream>

using namespace std;

extern "C" double average();

int main() {
    
    cout << "Welcome to Average Driving Time Calculator maintained by Quan Khong\n";
    double result = average();
    printf("%s%1.18lf%s", "\nThe main module received this number ", result,
           " and will keep it for a while.\n");
    return 0;
}