rm *.o
rm *.out
rm *.lis

echo "This is program <Edisons circuit Analyzer>"

echo "Assemble the module edison.asm"
nasm -f elf64 -l edison.lis -o edison.o edison.asm

echo "Assemble the module faraday.c"
gcc -c -g -m64 -Wall -no-pie -o faraday.o faraday.c -std=c11

echo "Link the object files already created"
g++ -m64 -no-pie -g -o edison.out -std=c++11 faraday.o edison.o

echo "Run the program Edisons circuit Analyzer"
./edison.out

echo "The bash script file is now closing."

rm *.o
rm *.out
rm *.lis
