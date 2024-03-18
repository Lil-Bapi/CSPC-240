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