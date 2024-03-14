// program name: Amazing Triangle a program that inputs the lengths of two sides 
// of a triangle and inputs the size of the angle between those two sides.   The 
// length of the third side is computed.  The three input values are validated by 
// suitable checking mechanism. 
// Copyright (C) <2024>  <Quan Khong>

// "Amazing Triangle" is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// "Amazing Triangle" is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with "Amazing Triangle".  If not, see <https://www.gnu.org/licenses/>.

// Author: Quan Khong
// Date: 02/22/2024

#include "stdio.h"

extern double ** director(unsigned long *n);

int main() {
   
    printf("Welcome to Arrays of floating point numbers.\n");
    printf("Bought to you by Quan Khong\n\n");

    unsigned long size = 0;
    double **arr = director(&size);
    printf("The main function received this set of numbers:\n");
    for (int i = 0; i < size; ++i) {
        printf("%.3lf\n", *(arr[i]));
    }
    printf("Main will keep these and send a zero to the operating system.\n");
    return 0;
}