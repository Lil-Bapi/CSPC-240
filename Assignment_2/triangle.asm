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

extern printf       
extern scanf 
extern fgets
extern stdin
extern strlen
extern isfloat
global triangle

max_name_size equ 64
max_title_size equ 64

segment .data

    align 16
    get_name    db "Please enter your name: ", 0
    get_title   db "Please enter your title (Sargent, Chief, CEO, President, Teacher, etc): ", 0
    
    goodmorning db "Good morning, %s %s. We take care of all your triangles", 10, 0

    get_side1   db "Please enter the length of the first side: ", 0
    get_side2   db "Please enter the length of the second side: ", 0
    get_angle   db "Please enter the size of the angle in degrees: ", 0
    invalid     db "Invalid input. try again:", 0

    thankyou    db "Thank you %s. You entered %1.6lf %1.6lf and %1.6lf", 0
    third_side  db "The length of the third side is %1.6lf", 0

    progress    db "The length will be sent to the driver program.", 0
    finaltime   db "he final time on the system clock is %1.6lf tics", 0

    farewell    db "Have a good day %s.", 0

    string_format   db "%s", 0
    double_format   db "%lf", 0

segment .bss
    align 64
    backup resb 900
    name resb max_name_size
    title resb max_title_size

segment .text

triangle:
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

    mov rax, 7
    mov rdi, 0
    xsave [backup]

; Ask Name
    mov qword   rax, 0
    mov         rdi, string_format
    mov         rsi, get_name
    call        printf 


; Obtain name
    mov qword rax, 0
    mov rdi, name
    mov rsi, max_name_size
    mov rdx, [stdin]
    call fgets

; compute the length of the name and remove the newline
    mov qword rax, 0
    mov rdi, name
    call strlen
    mov byte [name + rax - 1],byte 0

; Ask title
    mov qword   rax, 0
    mov         rdi, string_format
    mov         rsi, get_title
    call        printf 

; Obtain title
    mov qword rax, 0
    mov rdi, title
    mov rsi, max_title_size
    mov rdx, [stdin]
    call fgets

; compute the length of the name and remove the newline
    mov qword rax, 0
    mov rdi, title
    call strlen
    mov byte [title + rax - 1],byte 0

;print thank message
    mov qword rax, 0
    mov rdi, goodmorning
    mov rsi, title
    mov rdx, name
    call printf


; Ask for the length of the first side`
    mov qword   rax, 0
    mov         rdi, string_format
    mov         rsi, get_side1
    call        printf

; Obtain the length of the first side
    mov qword rax, 0
    mov rdi, double_format
    mov rsi, rsp
    call scanf
    movsd xmm8, [rsp]
    movsd xmm12, xmm0   ;xmm12 contain the length of the first side

; Ask for the length of the second side
    mov qword   rax, 0
    mov         rdi, string_format
    mov         rsi, get_side2
    call        printf

; Obtain the length of the second side
    mov qword rax, 0
    mov rdi, double_format
    mov rsi, rsp
    call scanf
    movsd xmm8, [rsp]
    movsd xmm13, xmm0   ;xmm13 contain the length of the second side

; Ask for the angle of the two sides
    mov qword   rax, 0
    mov         rdi, string_format
    mov         rsi, get_angle
    call        printf

; Obtain the angle of the two sides
    mov qword rax, 0
    mov rdi, double_format
    mov rsi, rsp
    call scanf
    movsd xmm8, [rsp]
    movsd xmm14, xmm0   ;xmm14 contain the size of the angle

; ; Compute the length of the third side
;     mov rax, 0
;     mov rdi, thankyou
;     mov rsi, name
;     movsd xmm0, xmm12
;     movsd xmm1, xmm13
;     movsd xmm2, xmm14
;     call triangle_length
;     movsd xmm15, xmm0

; Print the thank you message
    mov rax, 3
    mov rdi, thankyou
    mov rsi, name
    movsd xmm0, xmm12
    movsd xmm1, xmm13
    movsd xmm2, xmm14
    call printf

; ; Print the length of the third side    
;     mov rax, 0
;     mov rdi, third_side
;     movsd xmm0, xmm15
;     call printf
jmp exit

exit:
; Restoring the original value to the GPRs (jmp exit to exit this .asm file)

    ;return average speed to main
    ; movsd xmm0, xmm12 ;<<----- replace this with xmm register that contains the average speed
    
    ;State component restore
    mov rax, 7
    mov rdx, 0
    xrstor [backup]
    movsd xmm0, [rsp]

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