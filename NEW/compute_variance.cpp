#include <iostream>
#include <cmath>

extern "C" double compute_variance(double array [], int count, double mean);

double compute_variance(double array[], int count, double mean){
    double var = 0;
    for(int i = 1; i < count; ++i){
        var = var + (array[i] - mean) * (array[i] - mean);
    }
    var = var / count;
    return var;
}