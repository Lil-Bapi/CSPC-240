#include <iostream>
#include <cmath>

extern "C" double compute_variance(double array [], double mean, double count);

double compute_variance(double array[], double mean,  double count){
    double var = 0;
    std::cout << "This is count" <<count << std::endl;
    std::cout << "This is mean" <<mean << std::endl;
    for(int i = 0; i < count; i++){
        var = var + pow((array[i] - mean), 2);
    }
    var = var / count;
    std:: cout << var << std::endl;
    return var;
}