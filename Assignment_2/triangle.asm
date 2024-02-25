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

true equ -1
false equ 0

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
    invalid_in  db "Invalid input. try again: ", 0

    thankyou    db "Thank you %s. You entered %1.6lf %1.6lf and %1.6lf", 10, 0
    third_side  db "The length of the third side is %1.6lf", 0

    progress    db "The length will be sent to the driver program.", 0
    finaltime   db "he final time on the system clock is %1.6lf tics", 0

    farewell    db "Have a good day %s.", 0

    pi         dq 3.141
    radians    dq 180.0
    string_format   db "%s", 0
    format_float   db "%lf", 0

segment .bss
    align 64
    backup resb 900
    max_buffer_size equ 64
    name resb max_name_size
    title resb max_title_size
    angle resq 60
    side1 resq 60
    side2 resq 60
    

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
    mov         rdi, get_side1
    call        printf

triangle_side1:
; Obtain the length of the first side
    mov rax, 0
    mov rdi, side1
    mov rsi, 60
    mov rdx, [stdin]
    call fgets

; Remove the newline
    mov qword rax, 0
    mov rdi, side1
    call strlen
    mov byte [side1 + rax - 1],byte 0


; Convert the string to a double precision floating-point number\
    mov rax, 0
    mov rdi, side1   ; Pass the address
    call atof      ; Convert string to double
    movsd xmm12, xmm0   ;[side1] contain the size of the first side

; Check if valid input
    mov rax, 0
    mov rdi, side1
    call isfloat
    cmp rax, false
    je invalid_side1

; Ask for the length of the second side
    mov qword   rax, 0
    mov         rdi, get_side2
    call        printf

triangle_side2:
; Obtain the length of the second side
    mov rax, 0
    mov rdi, side2
    mov rsi, 60
    mov rdx, [stdin]
    call fgets

; Remove the newline
    mov qword rax, 0
    mov rdi, side2
    call strlen
    mov byte [side2 + rax - 1],byte 0

; Convert the string to a double precision floating-point number
    mov rax, 0
    mov rdi, side2   ; Pass the address
    call atof      ; Convert string to double
    movsd xmm13, xmm0   ;[side2] contain the size of the second side

; Check if valid input
    mov rax, 0
    mov rdi, side2
    call isfloat
    cmp rax, false
    je invalid_side2

; Ask for the size of the angle
    mov qword   rax, 0
    mov         rdi, get_angle
    call        printf

triangle_angle:
; Obtain the size of the angle
    mov rax, 0
    mov rdi, angle
    mov rsi, 60
    mov rdx, [stdin]
    call fgets

; Remove the newline
    mov qword rax, 0
    mov rdi, angle
    call strlen
    mov byte [angle + rax - 1],byte 0
    

; Convert the string to a double precision floating-point number
    mov rax, 0
    mov rdi, angle   ; Pass the address
    call atof      ; Convert string to double
    movsd xmm14, xmm0   ;xmm14 contain the size of the angle

; Check if valid input
    mov rax, 0
    mov rdi, angle
    call isfloat
    cmp rax, false
    je invalid_angle

; Print the thank you message
    mov rax, 3
    mov rdi, thankyou
    mov rsi, name
    movsd xmm0, xmm12  ;[side1] contain the size of the first side
    movsd xmm1, xmm13  ;[side2] contain the size of the second side
    movsd xmm2, xmm14  ;xmm14 contain the size of the angle
    call printf

; Compute the length of the third side: C = sqrt(A^2 + B^2 - 2ABcos(C))
    movsd xmm9, xmm12
    mulsd xmm9, xmm9    ; A^2

    movsd xmm10, xmm13
    mulsd xmm10, xmm10  ; B^2

    addsd xmm9, xmm10   ; A^2 + B^2

    movsd xmm11, xmm14
    divsd xmm11, [radians]  ; Convert the angle from degrees to radians
    mulsd xmm11, [pi]       ; Multiply the angle by pi
    movsd xmm0, xmm11
    call cos
    movsd xmm11, xmm0       ; cos(C)

    mulsd xmm11, xmm12  ; Times A
    mulsd xmm11, xmm13  ; Times B
    addsd xmm11, xmm11  ; 2ABcos(C)

    subsd xmm9, xmm11   ; A^2 + B^2 - 2ABcos(C)
    movsd xmm0, xmm9
    call sqrt
    movsd xmm9, xmm0    ; The length of the third side

; Print the length of the third side
    mov rax, 3               ; printf syscall number
    mov rdi, third_side      ; format string
    movsd xmm0, xmm9         ; xmm9 contains the length of the third side
    call printf


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

invalid_side1:
    mov rax, 0
    mov rdi, string_format
    mov rsi, invalid_in
    call printf
    jmp triangle_side1

invalid_side2:
    mov rax, 0
    mov rdi, string_format
    mov rsi, invalid_in
    call printf
    jmp triangle_side2

invalid_angle:
    mov rax, 0
    mov rdi, string_format
    mov rsi, invalid_in
    call printf
    jmp triangle_angle