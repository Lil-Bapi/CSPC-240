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
extern printf
extern scanf
extern input_array
extern display_array
extern output_array
extern commute_mean
extern compute_variance
extern isfloat
global manager

array_s equ 100

segment .data
    floatform db "%lf", 0
    stringFormat db "%s", 0
    
    message1 db "This program will manage your arrays of 64-bit floats", 10, 0
    message2 db "For the array enter a sequence of 64-bit floats separated by white space.", 10, 0
    message3 db "After the last input press enter followed by Control+D:", 10, 0

    outputting_array db 10, "These numbers were received and placed into an array",10, 0

    mean_message db 10, "The mean of the numbers in the array is %1.6lf", 10, 0 
    

    array_size db 8, 0

segment .bss
    align 16
    array resq array_s
    count_value resq 1
segment .text

manager:
    ;backup registers
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

    ; Initialize Parameters
    mov qword r14, 0                        ; Reserve register for number of elements in array.
    mov qword r13, 0                        ; Reserve register for Sum of integers in array

    ; Instructional Promps
    mov qword rdi, stringFormat                     
    mov qword rsi, message1              
    mov qword rax, 0
    call printf                             ; Prints out intructions prompt.

    ; Instructional Promps
    mov qword rdi, stringFormat                     
    mov qword rsi, message2              
    mov qword rax, 0
    call printf        

    ; Instructional Promps
    mov qword rdi, stringFormat                     
    mov qword rsi, message3              
    mov qword rax, 0
    call printf            

    ; Call input_array
    mov qword rdi, array                 ; Passes array into rdi register. (first argment)
    mov qword rsi, array_size            ; Passes the max array size into rsi register. (second argument)
    mov qword rax, 0
    call input_array                     ; Calls funtion input_array.
    mov [count_value], rax               ; Saves copy of input_array output into r14.
    mov r15, rax                         ; Saves copy of input_array output into r15.

    ; Print outputting_array
    mov qword rdi, stringFormat                     
    mov qword rsi, outputting_array              
    mov qword rax, 0
    call printf                             

    ; Print display_array
    mov qword rax, 0
    mov qword rdi, array
    mov qword rsi, r15
    call output_array

    ; Calls function sum to return the sum of integers in the array
    mov  rax, 0
    mov  rdi, array
    mov  rsi, [count_value]
    call commute_mean
    
    ; Move the result to a safe register (xmm15)
    movsd xmm15, xmm0


    mov rax, 1
    mov rdi, mean_message
    call printf
    
    ; Calls function to calculate the variance 
    mov rax, 0
    mov rdi, array          ; Pass array as the first argument
    mov rsi, [count_value]  ; Pass count as the second argument
    movsd xmm0, xmm15       ; Pass mean as the third argument
    call compute_variance   ; Call the function
    movsd xmm11, xmm0       ; Move the result to a safe register (xmm15)



    jmp exit

exit:

    movsd xmm0, xmm11

    ; Restoring the original value to the General Purpose Registers
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