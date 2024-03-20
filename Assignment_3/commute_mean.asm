; Program name: Array Manager a program that takes in the user's inputs of
; numbers. The inputed values within the array then are displayed and the mean
; is calculated which is also will be displayed.
; Copyright (C) <2024>  <Quan Khong>

; "Array Manager" is free software: you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation, either version 3 of the License, or
; (at your option) any later version.

; "Array Manager" is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.

; You should have received a copy of the GNU General Public License
; along with "Array Manager".  If not, see <https://www.gnu.org/licenses/>.

; Author: Quan Khong
; Date: 03/17/2024

global commute_mean

segment .data

segment .text

commute_mean:
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

    ;Registers rax, rip, and rsp are usually not backed up.

    ;Back up the incoming parameter
    mov     r14, rdi  ;r14 is the array
    mov     r15, rsi  ;r15 is the count of valid numbers in the array

    ;Block to create a loop
    xor     r13, r13   ;r13 is the loop counter

begin_loop:
    ; Check if we are done with the loop or not
    cmp     r13, r15
    jge     calculate_mean

    ; Add the current value to the total
    addsd   xmm8, [r14+8*r13]
    ;Increment the couter and jump to the next iteration
    inc     r13
    jmp     begin_loop

calculate_mean:

    ; Calculate the mean
    cvtsi2sd xmm12, r15
    divsd xmm8, xmm12

done:
    ; Move the calculated sum to xmm0
    movsd   xmm0, xmm8

    ; Restoring the original value to the GPRs
    popf
    pop     r15
    pop     r14
    pop     r13
    pop     r12
    pop     r11
    pop     r10
    pop     r9
    pop     r8
    pop     rdi
    pop     rsi
    pop     rdx
    pop     rcx
    pop     rbx
    pop     rbp

    ret