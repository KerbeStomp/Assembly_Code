;;;
;;; to_lower.s
;;;
section .data

string:    db      "ThE CAT in tHe hAT!!!", 10
STRLEN: equ     $ - string

section .text
global _start
_start:

    mov rdi, 0
start_do:

    ; if(char >= 'A' and char <= 'Z')
    mov al, byte [string + rdi]
    sub al, 'A'
    cmp al, 'Z' - 'A'
    jnbe endif

    ; Char. is uppercase
    add byte [string + rdi], 32

endif:
    inc rdi
    cmp rdi, STRLEN
    jne start_do

    ; Print string
    mov rax, 1
    mov rdi, 1
    mov rsi, string
    mov rdx, STRLEN
    syscall

    ; Exit
    mov rax, 60
    mov rdi, 0
    syscall
    






