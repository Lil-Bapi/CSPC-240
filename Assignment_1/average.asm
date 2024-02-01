extern printf       
extern scanf 
global average

max_name_size equ 64
max_title_size equ 64

segment .data
    get_name        db  "Please enter your first and last names:", 0
    get_title       db  "Please enter your title such as Lieutenant, Chief, Mr, Ms, Influencer, Chairman, Freshman, Foreman, Project Leader, etc:", 0 
    thank       db  "Thank you %s %s ", 0

    fulltosan   db  "Enter the number of miles traveled from Fullerton to Santa Ana: ", 0
    speed1      db  "Enter your average speed during that leg of the trip: ", 0

    santolong   db  "Enter the number of miles traveled from Santa Ana to Long Beach: ", 0
    speed2      db  "Enter your average speed during that leg of the trip: ", 0

    longtofull   db  "Enter the number of miles traveled from Long Beach to Fullerton: ", 0
    speed3       db  "Enter your average speed during that leg of the trip: ", 0
    
    proccessed  db  "The inputted data are being processed", 0
    
    totaldistance   db  "The total distance traveled is %lf miles.", 0
    time            db  "The time of the trip is $lf hours", 0
    averagespeed    db  "The average speed during this trip is $lf mph.", 0

    string_format db "%s", 0
    double_format db "%lf", 0

segment .bss
    align 64
    backup resb 900
    name resb max_name_size
    title resb max_title_size

segment .text

average:
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
    



exit:
; Restoring the original value to the GPRs (jmp exit to exit this .asm file)
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