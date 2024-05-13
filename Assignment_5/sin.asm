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



global sin
extern printf
extern scanf

segment .data

segment .bss

    align 64
    backup_storage_area resb 832


segment .text

sin:

    ;Back up the GPRs (General Purpose Registers)
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

    ;Backup the registers other than the GPRs
    mov rax,7
    mov rdx,0
    xsave [backup_storage_area]

    movsd xmm15, xmm0  ;permanant angle

    mov r15, rdi        ;starting count
    mov r14, 20         ;max count


    movsd xmm10, xmm15  ;will hold sin
    movsd xmm9, xmm15   ;will hold previous term
start:
    
    cmp r15, r14                ;Will check if n <= 20
    jge quit

    jmp Find_R                  ;Will find R

    add_R:
        mulsd xmm9, xmm13       ;multiplies R with previous term
        addsd xmm10, xmm9       ;adds new term to sin

        inc r15
        jmp start




Find_R:
    ;Work for numerator
    ;Numerator is stored in xmm13
    mov     rbx, r15    ;rbx = term counter
    movsd   xmm13, xmm15        ;xmm13 = x
    mulsd   xmm13, xmm13        ;xmm13 = x^2
    mov     r8, -1              ;moving -1 into r8
    cvtsi2sd xmm12, r8          ;using cvtsi2sd to convert. xmm12 = -1.0
    mulsd   xmm13, xmm12        ;xmm13 = -x^2

    ;Work for denominator
    ;Denominator is stored in "xmm14"
    imul     rbx, 2
    add     rbx, 2              ;rbx = 2n + 2

    mov     rcx, rbx            ;rcx = 2n + 2
    inc     rcx                 ;rcx = 2n + 3
    imul     rbx, rcx           ;rbx = denominator
    cvtsi2sd xmm14, rbx         ;xmm14 is not the denominator

    ;Dividing the numerator and denominator
    divsd   xmm13, xmm14        ;numerator / denominator --> Answer is stored in xmm13
    
    jmp add_R



quit:

    push qword 0
    movsd [rsp], xmm10


    ; Restore all the floating-point numbers
    mov rax, 7
    mov rdx, 0
    xrstor [backup_storage_area]

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
