; Program name: Area Machine is a program that will compute the are of a triangle
; given the length of two sides and the angle between them given by the user.
; Copyright (C) <2024>  <Quan Khong>

; "Area Machine" is free software: you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation, either version 3 of the License, or
; (at your option) any later version.

; "Area Machine" is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.

; You should have received a copy of the GNU General Public License
; along with "Area Machine".  If not, see <https://www.gnu.org/licenses/>.

; Author: Quan Khong
; Date: 05/12/2024


global producer
extern printf
extern scanf
extern atof
extern ftoa
extern strlen
extern sin

segment .data
    ;This section (or segment) is for declaring initialized array
    float_format db "%lf", 0
    pi dq 0x400921FB54442D18, 0
    half_circle dq 180.0, 0
    two dq 2.0, 0

    side_1 db 10, "Please enter the length of side 1: ", 0
    side_2 db     "Please enter the length of side 2: ", 0
    ask_angle  db     "Please enter the degress of the angle between: ", 0

    ;area   db 10, "The area of the triangle is ", 0
    ;area2  db     " sqaure feet.", 0

    thanks db     "Thank you for using a Quan product.", 10, 10,  0

segment .bss
    ;This section (or segment) is for declaring empty arrays

    align 64
    backup_storage_area resb 832

    side1 resb 10
    side2 resb 10
    angle resb 10

segment .text

producer:

    ;Back up the GPRs 
    push rbp
    mov rbp, rsp
    push rbx
    push rcx
    push rdx
    push rdi
    push rsi
    push r8
    push r9
    push r10
    push r11
    push r12
    push r13
    push r14
    push r15
    pushf

    ; Backup the registers other than the GPRs
    mov rax,7
    mov rdx,0
    xsave [backup_storage_area]

    ; output first side instructions
    mov rax, 1
    mov rdi, 1
    mov rsi, side_1
    mov rdx, 36
    syscall

    ; Take in user input
    mov rax, 0
    mov rdi, 0
    mov rsi, side1
    mov rdx, 10
    syscall

    ; Convert the user's input into a float
    mov rax, 0
    mov rdi, side1
    call atof
    movsd xmm15, xmm0

    ; Remove newline
    mov rax, 0
    lea rdi, [float_format]
    call strlen
    mov [float_format+rax-1], byte 0

    ; Output second side instructions
    mov rax, 1
    mov rdi, 1
    mov rsi, side_2
    mov rdx, 36
    syscall

    ; Take in user input
    mov rax, 0
    mov rdi, 0
    mov rsi, side2
    mov rdx, 10
    syscall

    ; Convert the user's input into a float
    mov rax, 0
    mov rdi, side2
    call atof
    movsd xmm14, xmm0

    ; Remove newline
    mov rax, 0
    lea rdi, [float_format]
    call strlen
    mov [float_format+rax-1], byte 0

    ; Ask for the angle between the two sides
    mov rax, 1
    mov rdi, 1
    mov rsi, ask_angle
    mov rdx, 48
    syscall

    ;Take in user input
    mov rax, 0
    mov rdi, 0
    mov rsi, angle
    mov rdx, 10
    syscall

    ;Convert the input into a float
    mov rax, 0
    mov rdi, angle
    call atof
    movsd xmm13, xmm0


    ;Remove newline
    mov rax, 0
    lea rdi, [float_format]
    call strlen
    mov [float_format+rax-1], byte 0

    ;convert angle to radians
    mov rax, 1
    mulsd xmm13, [pi]
    divsd xmm13, [half_circle]

    mov rax, 1
    ;mov r15, 0  ;starting count at 0
    movsd xmm0, xmm13 ;holds angle
    mov rdi, 0
    call sin
    movsd xmm13, xmm0

    ;calculate area
    movsd xmm12, xmm15
    mulsd xmm12, xmm14
    mulsd xmm12, xmm13
    divsd xmm12, [two]

    ;convert area to string
    mov rax, 0
    movsd xmm0, xmm12
    call ftoa


    ;output first side instructions
    mov rax, 1
    mov rdi, 1
    mov rsi, thanks
    mov rdx, 37
    syscall

    ;save rsp
    push qword 0
    movsd [rsp], xmm12

    ;Restore all the floating-point numbers
    mov rax, 7
    mov rdx, 0
    xrstor [backup_storage_area]

    ;Restore the floating-point stack
    movsd xmm0, [rsp]
    pop rax

    ;Restore the GPRs
    popf
    pop r15
    pop r14
    pop r13 
    pop r12
    pop r11
    pop r10
    pop r9
    pop r8
    pop rsi
    pop rdi
    pop rdx
    pop rcx
    pop rbx
    pop rbp 
    ret
