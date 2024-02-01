#!/bin/bash

#Author: 
#Program name: 

rm *.o
rm *.out
rm *.lis

echo "This is program <Calculate final average>"

echo "Assemble the module average.asm"
nasm -f elf64 -l average.lis -o average.o average.asm

echo "Compile the C++ module driver.cpp"
g++ -c -m64 -g -Wall -o driver.o driver.cpp -fno-pie -no-pie -std=c++17

echo "Link the two object files already created"
g++ -m64 -g -o final.out driver.o average.o -fno-pie -no-pie -std=c++17

echo "Run the program Basic Float Operations"
./final.out

echo "The bash script file is now closing."

rm *.o
rm *.out
rm *.lis
