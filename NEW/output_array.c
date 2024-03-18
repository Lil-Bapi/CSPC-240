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

#include <stdio.h>
extern void output_array(double array[], unsigned long);

// This function takes an array of doubles and prints them to the screen.
void output_array(double array[], unsigned long size) {
    for (unsigned long i = 0; i < size; ++i) {
      printf("%1.10lf ", (array[i]));
    }
}