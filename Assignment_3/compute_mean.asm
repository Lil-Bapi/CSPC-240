global compute_mean

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

    mov r14, rdi       ; Load the address of the array into r14
    mov cl, [r14]      ; Load the first element of the array into cl
    add r14, 1         ; Move to the second element

rotate_loop:
    mov dl, [r14]       ; Load the current element into dl
    mov [r14 - 1], dl   ; Move it one position to the left
    inc r14             ; Move to the next element
    loop rotate_loop

    mov [r14 - 1], cl   ; Move the first element to the end


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
