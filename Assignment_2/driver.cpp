// program name: Amazing Triangle a program that inputs the lengths of two sides 
// of a triangle and inputs the size of the angle between those two sides.   The 
// length of the third side is computed.  The three input values are validated by 
// suitable checking mechanism. 
// Copyright (C) <2023>  <Andy Nguyen>

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
#include <iostream>

using namespace std;

extern "C" double triangle();

int main() {
    
    cout << "Welcome to Amazing Triangles programmed by Quan Khong on February 20, 2024\n";
    double result = triangle();
    
    cout << "\nThe driver recieved this number" << result << " and will simply keep it.\n";
    cout << "A zero will be returned to the operating system.  Bye.\n";
}
