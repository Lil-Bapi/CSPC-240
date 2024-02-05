#include <stdio.h>
#include <iostream>

using namespace std;

extern "C" double average();

int main() {
    
    cout << "Welcome to Average Driving Time Calculator maintained by Quan Khong\n";
    double result = average();
    
    cout << "\nThe main function received this number " << result << " and will keep it for future study.\n";
    cout << "A zero will be returned to the operating system.  Bye.\n";
}