// Program name: Area Machine is a program that will compute the are of a triangle
// given the length of two sides and the angle between them given by the user.
// Copyright (C) <2024>  <Quan Khong>

// "Area Machine" is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// "Area Machine" is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with "Area Machine".  If not, see <https://www.gnu.org/licenses/>.

// Author: Quan Khong
// Date: 05/12/2024




#include <stdio.h>

extern double producer();

int main(int argc, const char * argv[])
{
printf("\nWelcome to Marvelous Quan's Area Machine!\n");
printf("Where we compuet all your areas.\n");

double area;
area = producer();

printf("\n\nthe driver recieved this number %1.5lf and will keep it.\n",area);
printf("A zero will be sent to the OS as a sign of successful conclusion.\nBye.\n");
}