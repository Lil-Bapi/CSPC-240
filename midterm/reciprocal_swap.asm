; Author name: Quan Khong
; Author email: kquan59@csu.fullerton.edu
; Course and section:  CPSC240-3
; Today’s date: Mar 20, 2024

global reciprocal_swap

segment .data
    
 
segment .text

reciprocal_swap:
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
    jge     done

    mov rax, 1
    cvtsi2sd   xmm8, rax ;move 1.0 to xmm8

    ; reciprocal_swap divides the current array index by 1
    movsd  xmm0, [r14+8*r13] ;Move the current array index to xmm0
    divsd xmm8, xmm0 ;Divide the current array index by 1 xmm0 = xmm0 / xmm8
    movsd [r14+8*r13], xmm8

    ;Increment the couter and jump to the next iteration
    inc     r13
    jmp     begin_loop

done:

    mov rax, r14

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