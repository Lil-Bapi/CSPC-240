; Program name: Circuit Analyzer Calucate the total resistance and voltage
; Copyright (C) <2024>  <Quan Khong>

; "Circuit Analyzer" is free software: you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation, either version 3 of the License, or
; (at your option) any later version.

; "Circuit Analyzer" is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.

; You should have received a copy of the GNU General Public License
; along with "Circuit Analyzer".  If not, see <https://www.gnu.org/licenses/>.

; Author: Quan Khong
; Email: kquan59@csu.fullerton.edu
; The class number: CPSC240-9
; Date: 05/13/2024

global edison
extern printf
extern scanf
extern input_array
extern isfloat
extern fgets
extern strlen
extern stdin
extern atof


array_s equ 3
max_name_size equ 64
max_data_size equ 64

segment .data
    floatform db "%lf", 0
    string_format db "%s", 0
    
    ask_for_name db 10, "Please enter your name: ", 0
    ask_for_resistance db 10, "Please enter the resistance for the three sub-circuits measured in Ohms separated by ws and press enter.", 10, 0

    print_resistance db 10, "Thank you. The total resistance in the full circuit is %lf Ohms.", 10, 0
    
    ask_for_current db 10, "Please enter the electic current of the enitre circuit: ", 0
    
    print_voltage db 10, "Thank you. The EMF in this circuit is %lf Volts", 10, 0

    goodbye db 10, "It was a please to serve you %lf", 10, 0
    array_size db 3, 0

segment .bss
    align 64
    backup resb 900
    array resq array_s
    count_value resq 1
    name resb max_name_size

    voltage resq max_data_size
    final_ohms resq max_data_size
    current resq max_data_size

segment .text

edison:

    ; Backup all General Purpose Registers
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
    
    ;State component save
    mov rax, 7
    mov rdx, 0
    xsave [backup]

    ; Ask Name
    mov qword   rax, 0
    mov         rdi, string_format
    mov         rsi, ask_for_name
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

    ; Ask for resistance
    mov qword   rax, 0
    mov         rdi, string_format
    mov         rsi, ask_for_resistance 
    call        printf

    ; Obtain the 3 resistances
    mov rdi, array
    mov rsi, array_s
    call input_array

    
calculating:
    ;1/resistence1 + 1/resistence2 + 1/resistence3 = 1/final_reistence
    mov rdi, array
    mov rsi, array_s
    call reciprocal_swap

    ; Sum the array
    mov rdi, array
    mov rsi, array_s
    call sum_array


    mov rax, 1
    cvtsi2sd   xmm8, rax ;move 1.0 to xmm8

    divsd xmm8, xmm9

    ; move xmm8 to final_ohms
    mov rdi, final_ohms
    movsd [rdi], xmm8

    ; print the final resistance
    mov qword   rax, 1
    mov rdi, print_resistance
    movsd xmm0, xmm8
    call printf

    ; Ask for the current
    mov qword   rax, 0
    mov         rdi, string_format
    mov         rsi, ask_for_current
    call        printf

    ; Obtain the current
    mov qword   rax, 0
    mov         rdi, floatform
    mov         rsi, rsp
    call        scanf
    movsd       xmm12, xmm0     ;xmm12 = current
    
    ; Calculate the voltage
    mulsd xmm12, xmm8

    ; print the voltage
    mov qword   rax, 1
    mov rdi, print_voltage
    movsd xmm0, xmm12
    call printf

done:
    ; Move the calculated sum to xmm0
    movsd   xmm0, xmm12

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


input_array:
    mov     r13, rdi    ; r13 contains the array
    mov     r14, rsi    ; r14 contains the max size
    mov     r15, 0      ; r15 is the index of the loop

begin:
    ; Ask for the input
    sub    rsp, 8
    mov     rdi, string_format
    mov     rsi, rsp
    call    scanf



    ; Convert the input into a float
    mov     rax, 0
    mov     rdi, rsp
    call    atof
    add    rsp, 8

    ; Copy the float into the array
    movsd   [r13 + r15 * 8], xmm0

    ; Increase r15, repeat the loop if r15 is less than the max size
    inc     r15
    cmp     r15, r14
    jl      begin

return:

    ret

reciprocal_swap:

    ;Back up the incoming parameter
    mov     r14, rdi  ;r14 is the array
    mov     r15, rsi  ;r15 is the count of valid numbers in the array

    ;Block to create a loop
    xor     r13, r13   ;r13 is the loop counter

reciprocal_swap_loop:
    ; Check if we are done with the loop or not
    cmp     r13, r15
    jge     return

    mov rax, 1
    cvtsi2sd   xmm8, rax ;move 1.0 to xmm8

    ; reciprocal_swap divides the current array index by 1
    movsd  xmm0, [r14+8*r13] ;Move the current array index to xmm0
    divsd xmm8, xmm0 ;Divide the current array index by 1 xmm0 = xmm0 / xmm8
    movsd [r14+8*r13], xmm8

    ;Increment the couter and jump to the next iteration
    inc     r13
    jmp     reciprocal_swap_loop

sum_array:

    ;Back up the incoming parameter
    mov     r14, rdi  ;r14 is the array
    mov     r15, rsi  ;r15 is the count of valid numbers in the array

    ;Block to create a loop
    xor     r13, r13   ;r13 is the loop counter

sum_array_loop:
    ; Check if we are done with the loop or not
    cmp     r13, r15
    jge     return

    ; Add the current value to the total
    addsd   xmm9, [r14+8*r13]
    ;Increment the couter and jump to the next iteration
    inc     r13
    jmp     sum_array_loop

