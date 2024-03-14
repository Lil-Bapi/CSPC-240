rm *.o
rm *.out
rm *.lis

echo "This is program <Assignment 3 - sort array>"

echo "Compile the C module main.c"
gcc -c -m64 -Wall -o main.o main.c -fno-pie -no-pie -std=c17

echo "Assemble the module director.asm"
nasm -f elf64 -l director.lis -o director.o director.asm

echo "Assemble the module inputarray.asm"
nasm -f elf64 -l inputarray.lis -o inputarray.o inputarray.asm

echo "Assemble the module outputarray.c"
gcc -c -m64 -Wall -o outputarray.o outputarray.c -fno-pie -no-pie -std=c17

echo "Assemble the module sortpointers.asm"
nasm -f elf64 -l sortpointers.lis -o sortpointers.o sortpointers.asm

echo "Link all the object files already created"
gcc -m64 -o array.out main.o director.o inputarray.o outputarray.o sortpointers.o -fno-pie -no-pie -std=c17

echo "Run the program Assignment 3 - sort array"
./array.out

echo "The bash script file is now closing."