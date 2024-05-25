;;;
;;; grades.s
;;;
section .data

prompt:     db      "Enter grades: ", 0
scanf_fmt:  db      " %ld", 0
results:    db      "High/low: %ld/%ld", 10, 0

section .text

extern printf
extern scanf
global main

main:
    push    rbp
    mov     rbp, rsp

    ; Reserve space on stack for high, low, grade
    sub     rsp, 8*3 

    ; Re-align stack
    sub     rsp, 8 

    ; printf("Enter grades: ");
    mov     rdi, prompt
    call    printf

begin:
    ; scanf(" %ld", &grade);
    mov     rdi, scanf_fmt
    mov     rsi, rbp
    sub     rsi, 24
    call    scanf

    ; if(grade == -1) break;
    cmp     qword [rbp-24], -1
    je      end_loop

    ; if(grade > high) high = grade;
    mov     r12,    qword [rbp-24] ; grade
    cmp     r12,    qword [rbp-8]  ; grade > high
    jng     endif1
    mov     qword [rbp-8], r12     ; high = grade
endif1:

    ; if(grade < low) low = grade;
    cmp     r12,    qword [rbp - 16]
    jnl     endif2
    mov     qword [rbp-16], r12    ; low = grade
endif2:

    jmp begin
end_loop:

    ; printf("High/low: %ld/%ld\n", high, low)
    mov     rdi, results
    mov     rsi, qword [rbp-8]
    mov     rdx, qword [rbp-16]
    call    printf

    add     rsp, 8*4
    pop     rbp
    mov     rax, 0
    ret