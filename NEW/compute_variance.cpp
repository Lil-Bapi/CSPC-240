// Program name: Array Manager a program that takes in the user's inputs of
// numbers. The inputed values within the array then are displayed and the mean
// is calculated which is also will be displayed.
// Copyright (C) <2024>  <Quan Khong>

// "Array Manager" is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// "Array Manager" is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with "Array Manager".  If not, see <https://www.gnu.org/licenses/>.

// Author: Quan Khong
// Date: 03/17/2024

#include <iostream>
#include <cmath>

extern "C" double compute_variance(double array [], int count, double mean);

double compute_variance(double array[], int count,  double mean){
    double var = 0;
    
    for(int i = 0; i < count; i++){
        var = var + pow((array[i] - mean), 2);
    }
    var = var / count;
    std:: cout << "The variance of the inputted numbers is " << var << std::endl;
    return var;
}