;;;
;;; calc.s
;;; Calculator
;;;
section .data

BUFLEN:     equ             256
buffer:     times BUFLEN    db 0

;              0                 1                  2                3                4  
jtbl:      dq  _start.case_plus, _start.case_minus, _start.case_mul, _start.case_div, _start.case_default
jmp_data:  db  '+', '-', '*', '/'

section .text
global _start

; Defines readint function
;   rdi = addr. of string
; Returns: 
;   rax = numeric value
;   rdx = addr. of space or newline
%include "readint.s"

_start:

.while:
    ; SYS_READ into buffer
    mov rax, 0        ; SYS_READ
    mov rdi, 0        ; STDIN
    mov rsi, buffer   ; Addr. of buffer
    mov rdx, BUFLEN   ; Len. of buffer
    syscall

    ; buffer:   _____ + _____\n
    ;             a       b
    mov rdi, buffer
    call readint
    mov r14, rax         ; r14 = a

    inc rdx     ; rdx points to operator
    mov r13b, byte [rdx] ; r13 = operator

    add rdx, 2  ; rdx points to b
    mov rdi, rdx
    call readint
    mov r15, rax         ; r15 = b

    ; switch(op) {
    ;   case '+':
    ;      rax = r14 + r15
    ;      break;
    ;   ...
    ; }  
    ;}

    ; Loop over jmp_data, searching for r13b
    mov rdi, 0 ; Array index
.while2:
    cmp rdi, 4
    je .end_while2

    cmp byte [jmp_data + rdi], r13b
    je .found

    inc rdi
    jmp .while2
    
.found:
.end_while2:    
    ; rdi = array index
    mov rax, qword [jtbl + 8*rdi]
    jmp rax

.case_plus:
    mov rax, r14
    add rax, r15
    jmp .end_switch

.case_minus:
    mov rax, r14
    sub rax, r15
    jmp .end_switch

.case_mul:
    mov  rax, r14
    imul r15         ; rax = rax * r15
    jmp .end_switch

.case_div:
    mov rdx, 0
    mov rax, r14
    div r15
    jmp .end_switch  

.case_default:
    mov rax, 0
    jmp .end_switch  

.end_switch:

    ; Print rax

    jmp .while

    mov rax, 60
    mov rdi, 0
    syscall






    