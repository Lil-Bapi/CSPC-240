// Author name: Quan Khong
// Author email: kquan59@csu.fullerton.edu
// Course and section:  CPSC240-3
// Today’s date: Mar 20, 2024


#include <stdio.h>
extern void output_array(double array[], unsigned long);

// This function takes an array of doubles and prints them to the screen.
void output_array(double array[], unsigned long size) {
    for (unsigned long i = 0; i < size; ++i) {
      printf("%1.5lf ", (array[i]));
    }
}