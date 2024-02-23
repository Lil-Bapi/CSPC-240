#include <stdio.h>
#include <iostream>

using namespace std;

extern "C" double triangle();

int main() {
    
    cout << "Welcome to Amazing Triangles programmed by Quan Khong on February 20, 2024\n";
    double result = triangle();
    
    cout << "\nThe driver recieved this number" << result << " and will simply keep it.\n";
    cout << "A zero will be returned to the operating system.  Bye.\n";
}