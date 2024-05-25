;;;
;;; grades.s
;;;
section .data

prompt:     db      "Enter grades: ", 0
scanf_fmt:  db      " %ld", 0
high_msg:   db      "Highest: %ld", 10, 0
low_msg:    db      "Lowest: %ld", 10, 0

section .text

extern printf
extern scanf

global main

main:
    push rbp
    mov rbp, rsp

    %define grade qword [rbp - 8]
    sub rsp, 8     ; Space for grade
    sub rsp, 8     ; Re-align stack

    ; Registers for min, max
    %define smallest r12
    %define largest  r13
    mov smallest, 10000000000000     ; min   
    mov largest,  -10000000000000    ; max

    mov rdi, prompt
    call printf

start_loop:
    ; scanf(" %ld", &grade);
    mov rdi, scanf_fmt
    lea rsi, grade
    call scanf

    ; if(grade == -1) break;
    cmp grade, -1
    je end_loop

    ; if(grade < min) min = grade
    cmp grade, smallest
    cmovl smallest, grade

    ; if(grade > max) max = grade
    cmp grade, largest
    cmovg largest, grade
    
    jmp start_loop

end_loop:

    ; printf("Largest: %ld\n", max);
    mov rdi, high_msg
    mov rsi, largest
    call printf

    ; printf("Smallest: %ld\n", min);
    mov rdi, low_msg
    mov rsi, smallest
    call printf

    ; Clean up stack
    add rsp, 16
    pop rbp
    mov rax, 0
    ret

    %undef smallest
    %undef largest

