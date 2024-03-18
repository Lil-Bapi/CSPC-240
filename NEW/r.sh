#!/bin/bash

#Author: Andy Nguyen
#Program name: Sum of array

rm *.o
rm *.out
rm *.lis

echo "This is program <gives the sum of an array>"

echo "Assemble the module manage.asm"
nasm -f elf64 -l manage.lis -o manage.o manage.asm

echo "Assemble the module input_array.asm"
nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm

echo "Assemble the module output_array.asm"
nasm -f elf64 -l output_array.lis -o output_array.o output_array.asm

echo "Assemble the module sum_array.asm"
nasm -f elf64 -l sum_array.lis -o sum_array.o sum_array.asm

echo "Compile the C module main.c"
gcc -c -g -m64 -Wall -no-pie -o main.o main.c -std=c11

echo "Compile the C++ module compute_variance.cpp"
g++ -c -g -m64 -Wall -o compute_variance.o compute_variance.cpp -std=c++11

echo "Link the object files already created"
g++ -m64 -no-pie -g -o array.out -std=c++11 main.o manage.o input_array.o output_array.o sum_array.o compute_variance.o

echo "Run the program Basic Float Operations"
./array.out

echo "The bash script file is now closing."

rm *.o
rm *.out
rm *.lis