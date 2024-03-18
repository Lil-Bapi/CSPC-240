; Author name: Andy Nguyen
; Author email: andynguyendo@csu.fullerton.edu

extern printf
global output_array

segment .data
    format db "%lf", 10, 0     ; Format string for printing 64-bit integers with a newline

segment .bss

segment .text

output_array:
    ; Back up all the GPRs
    push rbp
    mov rbp, rsp
    push rdi
    push rsi
    push rdx
    push rcx
    push r8
    push r9
    push r10
    push r11
    push r12
    push r13
    push r14
    push r15
    push rbx
    pushf

    ; Call your print_array function, passing the address of the array and its size
    mov r14, rdi    ;r14 is the array
    mov r15, rsi    ;r15 is the number of cells in the array

    ; Loop counter
    xor r13, r13

print_loop:
    ; Check if we've reached the end of the array (loop counter == array size)
    cmp r13, r15
    je print_done

    ; r14 is the address of the array. r13 is like the "index"
    ; of the array. By multiplying r13 * 8, we move 8 bytes to the
    ; next iteration to input more numbers.
    movsd xmm0, [r14 + r13*8]
    mov rax, 1
    mov rdi, format
    call printf

    inc r13 ;r13++

    jmp print_loop

print_done:
    ; Restoring the original value to the GPRs
    popf
    pop  r15
    pop  r14
    pop  r13
    pop  r12
    pop  r11
    pop  r10
    pop  r9
    pop  r8
    pop  rsi
    pop  rdi
    pop  rdx
    pop  rcx
    pop  rbx
    pop  rbp
    
    ret