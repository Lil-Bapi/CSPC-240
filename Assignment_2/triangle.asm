; program name: Amazing Triangle a program that inputs the lengths of two sides 
; of a triangle and inputs the size of the angle between those two sides.   The 
; length of the third side is computed.  The three input values are validated by 
; suitable checking mechanism. 
; Copyright (C) <2023>  <Andy Nguyen>

; "Amazing Triangle" is free software: you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation, either version 3 of the License, or
; (at your option) any later version.

; "Amazing Triangle" is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.

; You should have received a copy of the GNU General Public License
; along with "Amazing Triangle".  If not, see <https://www.gnu.org/licenses/>.

; Author: Quan Khong
; Date: 02/22/2024
segment .data

segment .bss

segment .text

extern printf       
extern scanf 
extern fgets
extern stdin
extern strlen
global average

max_name_size equ 64
max_title_size equ 64

segment .data

    align 16
    get_name    db "Please enter your name: ", 0
    get_title   db "Please enter your title (Sargent, Chief, CEO, President, Teacher, etc)", 0
    
    goodmorning db "Good morning, %s %s. We take care of all your triangles", 0

    get_side1   db "Please enter the length of the first side: ", 0
    get_side2   db "Please enter the length of the second side: ", 0
    get_angle   db "Please enter the size of the angle in degrees: ", 0
    invalid     db "Invalid input. try again:", 0

    thankyou    db "Thank you %s. You entered %1.6lf %1.6lf and %1.6lf", 0
    third_side  db "The length of the third side is %1.6lf", 0

    progress    db "The length will be sent to the driver program.", 0
    finaltime   db "he final time on the system clock is %1.6lf tics", 0

    farewell    db "Have a good day %s.", 0

