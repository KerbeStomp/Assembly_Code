;;;
;;; hello_c.s
;;;
section .data

msg:    db      "Hello, world!", 10, 0

section .text

global main
extern printf

main:
    push rbp
    mov rbp, rsp

    mov rdi, msg
    call printf

    pop rbp
    mov rax, 0
    ret