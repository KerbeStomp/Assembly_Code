;;;
;;; hello10.s
;;;
section .data

hello:      db      "Hello!", 10
HELLO_LEN:  equ     $-hello

section .text

global _start
_start:

    mov rcx, 10
begin:
    ; Print Hello! once
    mov rax, 1
    mov rdi, 1
    mov rsi, hello
    mov rdx, HELLO_LEN

    mov r12, rcx
    syscall
    mov rcx, r12

    loop begin

    ; SYS_EXIT
    mov rax, 60
    mov rdi, 0
    syscall



    