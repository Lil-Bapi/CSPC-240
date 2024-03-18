; Author name: Andy Nguyen
; Author email: andynguyendo@csu.fullerton.edu

extern scanf
extern printf
global input_array

segment .data
    floatform db "%lf", 0
    string_format db "%s", 0

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

    pop rax

    mov r14, rdi    ; r14 is the array
    mov r15, rsi    ; r15 is the upper-limit of the number of cells in the array
    xor r13, r13    ; r13 to count input
    jmp input_loop

    ; A loop that will keep asking for more floating-point numbers until
    ; the user presses ctrl-d
input_loop:
    ; if the current index is greater than or equal to 
    ; the upper-limit, conclude the loop.
    cmp r13, r15
    jge input_finished

    ; Read a floating point number from user
    mov rax, 0
    mov rdi, floatform
    push qword  0
    mov rsi, rsp
    call scanf       ; either a float number or ctrl-d

    cdqe
    cmp rax, -1
    je input_finished

    pop rax
    ; r14 is the address of the array. r13 is like the "index"
    ; of the array. By multiplying r13 * 8, we move 8 bytes to the
    ; next iteration to input more numbers.
    mov [r14 + r13*8], rax
    inc r13

    cmp r13, r15
    je input_finished

    jmp input_loop

input_finished:
    ; r13 holds the count of numbers in the array.
    ; Move it to rax as we are required to return that number.
    mov rax, r13

    popf                                                 
    pop rbx                                                     
    pop r15                                                     
    pop r14                                                      
    pop r13                                                      
    pop r12                                                      
    pop r11                                                     
    pop r10                                                     
    pop r9                                                      
    pop r8                                                      
    pop rcx                                                     
    pop rdx                                                     
    pop rsi                                                     
    pop rdi                                                     
    pop rbp

    ret