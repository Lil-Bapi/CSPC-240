#!/bin/bash

# Author name: Quan Khong
# Author email: kquan59@csu.fullerton.edu
# Course and section:  CPSC240-3
# Today’s date: Mar 20, 2024

rm *.o
rm *.out
rm *.lis

echo "This is program <Fantastic Reciprocals>"

echo "Assemble the module manager.asm"
nasm -f elf64 -l manager.lis -o manager.o manager.asm

echo "Assemble the module input_array.asm"
nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm

echo "Assemble the module isfloat.asm"
nasm -f elf64 -l isfloat.lis -o isfloat.o isfloat.asm

echo "Assemble the module reciprocal_swap.asm"
nasm -f elf64 -l reciprocal_swap.lis -o reciprocal_swap.o reciprocal_swap.asm

echo "Assemble the module sum_array.asm"
nasm -f elf64 -l sum_array.lis -o sum_array.o sum_array.asm

echo "Compile the C module output_array.c"
gcc -c -g -m64 -Wall -o output_array.o output_array.c -std=c11

echo "Compile the c module driver.c"
gcc -c -g -m64 -Wall -o driver.o driver.c -std=c11

echo "Link the object files already created"
g++ -m64 -no-pie -g -o array.out -std=c++11 driver.o reciprocal_swap.o manager.o sum_array.o input_array.o isfloat.o output_array.o

echo "Run the program Fantastic Reciprocals"
./array.out

echo "The bash script file is now closing."

rm *.o
rm *.out
rm *.lis
