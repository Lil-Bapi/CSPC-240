rm *.o
rm *.out
rm *.lis

echo "This is program <Assignment 3 - sort array>"

echo "Compile the C module driver.c"
gcc -c -m64 -Wall -o driver.o driver.c -fno-pie -no-pie -std=c17

echo "Assemble the module manager.asm"
nasm -f elf64 -l manager.lis -o manager.o manager.asm

echo "Assemble the module input_array.asm"
nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm

echo "Assemble the module isfloat.asm"
nasm -f elf64 -l isfloat.lis -o isfloat.o isfloat.asm

echo "Assemble the module output_array.c"
gcc -c -m64 -Wall -o output_array.o output_array.c -fno-pie -no-pie -std=c17

echo "Assemble the module compute_mean.asm"
nasm -f elf64 -l compute_mean.lis -o compute_mean.o compute_mean.asm

echo "Link all the object files already created"
gcc -m64 -o array.out driver.o manager.o input_array.o output_array.o compute_mean.o -fno-pie -no-pie -std=c17

echo "Run the program Assignment 3 - sort array"
./array.out

rm *.o
rm *.out
rm *.lis

echo "The bash script file is now closing."