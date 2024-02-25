#!/bin/bash

#Author: Quan Khong
#Program name: Amazing Triangle

rm *.o
rm *.out
rm *.lis

echo "This is program <Amazing Triangle>"

echo "Assemble the module triangle.asm"
nasm -f elf64 -l triangle.lis -o triangle.o triangle.asm

echo "Assemble the module isfloat.asm"
nasm -f elf64 -l isfloat.lis -o isfloat.o isfloat.asm

echo "Compile the C++ module driver.cpp"
g++ -c -m64 -Wall -l driver.lis -o driver.o driver.cpp -fno-pie -no-pie

echo "Link the object files"
g++ -m64 -o final.out driver.o triangle.o isfloat.o -fno-pie -no-pie

echo "Run the program Amazing Triangle"
./final.out

rm *.o
rm *.out
rm *.lis

echo "The bash script file is now closing."