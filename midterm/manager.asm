; Author name: Quan Khong
; Author email: kquan59@csu.fullerton.edu
; Course and section:  CPSC240-3
; Today’s date: Mar 20, 2024

global manager
extern printf
extern input_array
extern isfloat
extern output_array
extern reciprocal_swap
extern sum_array


array_s equ 100

segment .data
    floatform db "%lf", 0
    string_format db "%s", 0
    
    introduction db 10, "This program is maintained by Quan Khong.", 10, 0
    instructions db "Please enter your floating point number separated by white space.  The upper limit is 10 inputted numbers.  Press control D to stop.", 10, 0

    output_reciprocals db "The array of reciprocals is ", 0

    output_sum db 10, "The sum is %1.5lf", 0
    

    array_size db 100, 0

segment .bss
    align 64
    backup resb 900
    array resq array_s
    count_value resq 1
segment .text

manager:

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

    ;Print the introduction
    mov qword rax, 0
    mov rdi, string_format
    mov rsi, introduction
    call printf

    ;Print the instructions
    mov qword rax, 0
    mov rdi, string_format
    mov rsi, instructions
    call printf

    ;call input array
    mov qword rax, 0
    mov rdi, array
    mov rsi, array_size
    call input_array
    mov [count_value], rax
    mov r15, rax

    ;call reciprocal_swap
    mov qword rax, 0
    mov rdi, array
    mov rsi, r15
    call reciprocal_swap

    ;print the reciprocals
    mov qword rax, 0
    mov rdi, string_format
    mov rsi, output_reciprocals
    call printf

    ;call output_array
    mov qword rax, 0
    mov rdi, array
    mov rsi, r15
    call output_array

    ;call sum_array
    mov  rax, 0
    mov  rdi, array
    mov  rsi, r15
    call sum_array
    
    movsd xmm15, xmm0

    ;print the sum (xmm15)
    mov qword rax, 1
    mov rdi, output_sum
    movsd xmm0, xmm15
    call printf
    

done:
    ; Move the calculated sum to xmm0
    movsd   xmm0, xmm15

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