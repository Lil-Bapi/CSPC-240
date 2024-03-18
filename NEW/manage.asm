; Author name: Andy Nguyen
; Author email: andynguyendo@csu.fullerton.edu
; For: Assignment 2 - Array Management System
; Purpose of this file:
; This is the manage.asm module used to create an array of doubles using user input.
; This assembly module will return an array of doubles, and will modify the parameter
; coming from rdi to be the number of inputs from the user.
; Completion Date: 09/23/2023

extern printf
extern scanf
extern input_array
extern display_array
extern output_array
extern sum_array
extern compute_variance
extern isfloat
global manage

array_s equ 8

segment .data
    floatform db "%lf", 0
    stringFormat db "%s", 0
    
    message1 db "This program will manage your arrays of 64-bit floats", 10, 0
    message2 db "For the array enter a sequence of 64-bit floats separated by white space.", 10, 0
    message3 db "After the last input press enter followed by Control+D:", 10, 0

    outputting_array db 10, "These numbers were received and placed into an array",10, 0

    mean_message db 10, "The mean of the numbers in the array is %1.6lf", 10, 0 
    variance_message db "The variance of the inputted numbers is ", 0

    array_size db 8, 0

segment .bss
    align 16
    array resq array_s

segment .text

manage:
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
    call input_array                        ; Calls funtion input_array.
    mov r14, rax                            ; Saves copy of input_array output into r14.

    ; Print outputting_array
    mov qword rdi, stringFormat                     
    mov qword rsi, outputting_array              
    mov qword rax, 0
    call printf                             

    ; Print display_array
    mov qword rdi, array
    mov qword rsi, r14
    mov qword rax, 0
    call output_array

    ; Calls function sum to return the sum of integers in the array
    mov qword rax, 0
    mov qword rdi, array
    mov qword rsi, r13
    call sum_array
    
    ; Move the result to a safe register (xmm15)
    movsd xmm15, xmm0

    mov rax, 1
    mov rdi, mean_message
    call printf

    ; Calls function to calculate the variance 
    mov rdi, array          ; Pass array as the first argument
    mov rsi, r14            ; Pass count as the second argument
    movsd xmm0, xmm15       ; Pass mean as the third argument
    call compute_variance   ; Call the function
    
    jmp exit

exit:

    movsd xmm0, xmm15
    mov rax, r13    ; We need to move the value of r13 to rax because r13 will be restored

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

    ; makes the value of the parameter to the number of user inputs
    mov qword [rdi], rax
    mov rax, array      ; Return the array to the C module

    ret