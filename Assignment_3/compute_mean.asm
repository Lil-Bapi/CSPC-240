global compute_mean
extern printf

segment .data
    floatform db "%lf", 0

segment .bss
    align 64
    backup resb 900

segment .text

compute_mean:
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

    mov r13, rdi       ; Load the address of the array into r14
    mov r14, rsi       ; Load the size of the array into r15
    pxor xmm10, xmm10  ; Set xmm10 to 0

    mov r15, 0         ; r15 is counter for the loop

sum_loop:
    cmp r15, r14       ; Check if we have reached the end of the array
    je exit

    ; Add the current element to xmm10 (xmm10 is the sum of all the elements)
    addsd xmm10, [r13+r15*8] ; r13 is the address of the array, r15 is the counter

    inc r15             ; Move to the next element
    jmp sum_loop

    
    ; ; Calculate the mean
    ; movq xmm11, r14
    ; divsd xmm10, xmm11
    ; movsd [rsp], xmm10

    ;move xmm10 to a printable register using printf
    

    movsd [rsp], xmm10


    ; ; Display sum for debugging purposes
    ; mov rax, 1
    ; mov rdi, floatform
    ; mov rsi, [rsp]
    ; call printf

exit:
; Restoring the original value to the GPRs (jmp exit to exit this .asm file)

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
