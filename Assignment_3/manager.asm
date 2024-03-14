; program name: Amazing Triangle a program that inputs the lengths of two sides 
; of a triangle and inputs the size of the angle between those two sides.   The 
; length of the third side is computed.  The three input values are validated by 
; suitable checking mechanism. 
; Copyright (C) <2024>  <Quan Khong>

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

extern printf       
extern scanf 
extern fgets
extern stdin
extern strlen
extern isfloat
extern cos
extern sqrt
extern atof
global triangle

segment .data
    message1 db "This program will manage your arrays of 64-bit floats", 0
    message2 db "For the array enter a sequence of 64-bit floats separated by white space."
    message3 db "After the last input press enter followed by Control+D:"

    outputting_array db "These numbers were received and placed into an array",10, 0

    mean db "The mean of the numbers in the array is "    
    

segment .text

manager:
; Back up all the GPRs
    push    rbp
    mov     rbp, rsp
    push    rbx
    push    rcx
    push    rdx
    push    rsi
    push    rdi
    push    r8
    push    r9
    push    r10
    push    r11
    push    r12
    push    r13
    push    r14
    push    r15
    pushf



jmp exit
    

exit:
; Restoring the original value to the GPRs (jmp exit to exit this .asm file)

    push qword 0
    movsd [rsp], xmm9

    ;State component restore
    mov rax, 7
    mov rdx, 0
    xrstor [backup]

    movsd xmm0, [rsp]
    pop rax

    popf
    pop        r15
    pop        r14
    pop        r13
    pop        r12
    pop        r11
    pop        r10
    pop        r9
    pop        r8
    pop        rdi
    pop        rsi
    pop        rdx
    pop        rcx
    pop        rbx
    pop        rbp

    ret
