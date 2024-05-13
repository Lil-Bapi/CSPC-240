# Program name: Area Machine is a program that will compute the are of a triangle
# given the length of two sides and the angle between them given by the user.
# Copyright (C) <2024>  <Quan Khong>

# "Area Machine" is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# "Area Machine" is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTYwithout even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with "Area Machine".  If not, see <https://www.gnu.org/licenses/>.

# Author: Quan Khong
# Date: 05/12/2024

rm *.o
rm *.out
rm *.lis

echo "This is program gives you the area of a triangle"  

echo "Assemble the module producer.asm"
nasm -f elf64 -l producer.lis -o producer.o producer.asm

echo "Compile the C module director.c"
gcc -c -g -m64 -Wall -no-pie -o director.o director.c -std=c11

echo "Assemble the module sin.asm"
nasm -f elf64 -l sin.lis -o sin.o sin.asm

echo "Compile the C module ftoa.c"
gcc -c -g -m64 -Wall -no-pie -o ftoa.o ftoa.c -std=c11

echo "Link the object files already created"
g++ -m64 -no-pie -g -o random.out -std=c++11 ftoa.o producer.o director.o sin.o

echo "Run the program Basic Float Operations"
./random.out

echo "The bash script file is now closing."

rm *.o
rm *.out
rm *.lis

