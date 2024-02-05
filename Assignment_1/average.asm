extern printf       
extern scanf 
extern fgets
extern stdin
extern strlen
global average

max_name_size equ 64
max_title_size equ 64

segment .data

    align 16

    get_name        db  "Please enter your first and last names:", 0
    get_title       db  "Please enter your title such as Lieutenant, Chief, Mr, Ms, Influencer, Chairman, Freshman, Foreman, Project Leader, etc:", 0 
    thank           db  "Thank you %s %s ", 10, 10, 0

    fulltosan       db  "Enter the number of miles traveled from Fullerton to Santa Ana: ", 0
    speed1          db  "Enter your average speed during that leg of the trip: ", 0

    santolong       db  "Enter the number of miles traveled from Santa Ana to Long Beach: ", 0
    speed2          db  "Enter your average speed during that leg of the trip: ", 0

    longtofull      db  "Enter the number of miles traveled from Long Beach to Fullerton: ", 0
    speed3          db  "Enter your average speed during that leg of the trip: ", 0
    
    proccessed      db  "The inputted data are being processed", 10, 0
    
    totaldistance   db  "The total distance traveled is %.6lf miles.", 10, 0
    totaltime       db  "The time of the trip is %1.8lf hours", 10, 0
    averagespeed    db  "The average speed during this trip is %1.8lf mph.", 10, 0

    string_format   db "%s", 0
    double_format   db "%lf", 0

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

    mov rax, 7
    mov rdi, 0
    xsave [backup]

; Ask Name
    mov qword   rax, 0
    mov         rdi, string_format
    mov         rsi, get_name
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

; Ask title
    mov qword   rax, 0
    mov         rdi, string_format
    mov         rsi, get_title
    call        printf 

; Obtain title
    mov qword rax, 0
    mov rdi, title
    mov rsi, max_title_size
    mov rdx, [stdin]
    call fgets

; compute the length of the name and remove the newline
    mov qword rax, 0
    mov rdi, title
    call strlen
    mov byte [title + rax - 1],byte 0

;print thank message
    mov qword rax, 0
    mov rdi, thank
    mov rsi, title
    mov rdx, name
    call printf

; Trip one
    mov qword   rax, 0
    mov         rdi, string_format
    mov         rsi, fulltosan
    call        printf

; Obtain trip one distance
    mov qword   rax, 0
    mov         rdi, double_format
    mov         rsi, rsp
    call        scanf
    movsd       xmm8, [rsp]
    movsd       xmm12, xmm0     ;xmm12 cotain fulltosan miles

; Trip one average speed
    mov qword   rax, 0
    mov         rdi, string_format
    mov         rsi, speed1
    call        printf

; Obtain trip one speed
    mov qword   rax, 0
    mov         rdi, double_format
    mov         rsi, rsp
    call        scanf
    movsd       xmm8, [rsp]
    movsd       xmm13, xmm0     ;xmm13 cotain fulltosan speed

; Trip two distance
    mov qword   rax, 0
    mov         rdi, string_format
    mov         rsi, santolong
    call        printf

; Obtain trip second distance
    mov qword   rax, 0
    mov         rdi, double_format
    mov         rsi, rsp
    call        scanf
    movsd       xmm8, [rsp]
    movsd       xmm14, xmm0     ;xmm14 cotain santolong miles

; Trip two average
    mov qword   rax, 0
    mov         rdi, string_format
    mov         rsi, speed2
    call        printf

; Obtain trip two speed
    mov qword   rax, 0
    mov         rdi, double_format
    mov         rsi, rsp
    call        scanf
    movsd       xmm8, [rsp]
    movsd       xmm15, xmm0     ;xmm15 cotain santolong speed

; Trip three distance
    mov qword   rax, 0
    mov         rdi, string_format
    mov         rsi, longtofull
    call        printf

; Obtain trip three distance
    mov qword   rax, 0
    mov         rdi, double_format
    mov         rsi, rsp
    call        scanf
    movsd       xmm8, [rsp]
    movsd       xmm11, xmm0     ;xmm11 cotain longtofull miles

; Trip three average
    mov qword   rax, 0
    mov         rdi, string_format
    mov         rsi, speed3
    call        printf

; Obtain trip three speed
    mov qword   rax, 0
    mov         rdi, double_format
    mov         rsi, rsp
    call        scanf
    movsd       xmm8, [rsp]
    movsd       xmm10, xmm0     ;xmm10 cotain longtofull speed

; Print process line
    mov qword   rax, 0
    mov         rdi, string_format
    mov         rsi, proccessed
    call        printf 

;xmm12 = fulltosan miles
;xmm13 = fulltosan speed
;xmm14 = santolong miles
;xmm15 = santolong speed
;xmm11 = longtofull miles
;xmm10 = longtofull speed

; Calculation
    movsd xmm0, xmm12    
    addsd xmm0, xmm14    
    addsd xmm0, xmm11 

    movsd [rsp], xmm0

; Print total distance
    mov qword   rax, 1
    mov         rdi, totaldistance
    movsd       xmm0, [rsp]
    call        printf


; Calculation
    divsd xmm11, xmm10    
    divsd xmm12, xmm13  
    divsd xmm14, xmm15
    
    addsd xmm11, xmm12
    addsd xmm11, xmm14        ;total time

    
; Print total time
    ; mov qword   rax, 1
    mov         rdi, totaltime
    movsd       xmm0, xmm11
    call        printf

    movsd   xmm0, [rsp]
; Calculation 
    divsd   xmm0, xmm11
    movsd   [rsp], xmm0

; Print average speed
    mov qword   rax, 1
    mov         rdi, averagespeed
    movsd       xmm0, [rsp]
    call        printf


jmp exit

exit:
; Restoring the original value to the GPRs (jmp exit to exit this .asm file)

    ;return average speed to main
    ; movsd xmm0, xmm12 ;<<----- replace this with xmm register that contains the average speed
    
    ;State component restore
    mov rax, 7
    mov rdx, 0
    xrstor [backup]
    movsd xmm0, [rsp]

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