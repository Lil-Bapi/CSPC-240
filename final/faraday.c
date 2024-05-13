// Program name: Circuit Analyzer Calucate the total resistance and voltage
// Copyright (C) <2024>  <Quan Khong>

// "Circuit Analyzer" is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// "Circuit Analyzer" is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with "Circuit Analyzer".  If not, see <https://www.gnu.org/licenses/>.

// Author: Quan Khong
// Email: kquan59@csu.fullerton.edu
// The class number: CPSC240-9
// Date: 05/13/2024


#include "stdio.h"

extern double edison();

int main() {
   
    printf("Welcome to Edison's Circuit Analyzer.\n");

    double answer = edison();

    printf("\nThe driver recieved %.6lf, and will keep it for future use.\n", answer);
    printf("\nHave a great day.\n");
    return 0;
}