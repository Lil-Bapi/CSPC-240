; program name: sort_array takes an array and sorts it from lease to 
; greatest. Copyright (C) <2023>  <Quan Khong>

; "sort_array" is free software: you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation, either version 3 of the License, or
; (at your option) any later version.

; "sort_array" is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.

; You should have received a copy of the GNU General Public License
; along with "sort_array".  If not, see <https://www.gnu.org/licenses/>.

; Author: Quan Khong
; Date: 10/8/2023

extern scanf
extern malloc
global input_array

segment .data
    floatform db "%lf", 0

segment .bss
    align 64
    backup resb 900

segment .text

input_array:
    ; Back up all the GPRs
    push rbp
    mov rbp, rsp
    push rbx
    push rcx
    push rdx
    push rsi
    push rdi
    push r8
    push r9
    push r10
    push r11
    push r12
    push r13
    push r14
    push r15
    pushf

    ;state component backup
    mov rax, 7
    mov rdx, 0
    xsave [backup]

    mov r14, rdi    ; r14 is the array
    mov r15, rsi    ; r15 is the max number of elements
    xor r13, r13    ; r13 to count input
    jmp input_number

input_number:
    ; Checks if the user has inputted more numbers than the max
    cmp r13, r15
    jge input_finished

    ; allocates a block of memory of the specified size
    mov rax, 0
    mov rdi, 8
    call malloc
    mov r12, rax

    ; reads the input from the user
    mov rax, 0
    mov rdi, floatform
    mov rsi, r12
    call scanf

    ; checks if the user has inputted -1 to stop the program
    cdqe
    cmp rax, -1
    je input_finished

    mov [r14 + r13*8], r12
    inc r13
    jmp input_number

input_finished:
    ;state component restore
    mov rax, 7
    mov rdx, 0
    xrstor  [backup]

    ; r13 holds the count of numbers in the array.
    mov rax, r13

    ; Restoring the original value to the GPRs
    popf
    pop r15
    pop r14
    pop r13
    pop r12
    pop r11
    pop r10
    pop r9
    pop r8
    pop rdi
    pop rsi
    pop rdx
    pop rcx
    pop rbx
    pop rbp

    ret