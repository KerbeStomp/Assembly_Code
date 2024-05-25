;;;
;;; hello10.s
;;; Prints Hello 10 times
;;;
section .data

msg:    db      "Hello", 10
MSGLEN: equ     ($ - msg)

section .text

global _start
_start:

    mov     rcx,    10
start_loop:
    mov     rax,    1   ; SYS_WRITE
    mov     rdi,    1   ; STDOUT
    mov     rsi,    msg
    mov     rdx,    MSGLEN

    mov     r8,     rcx
    syscall
    mov     rcx,    r8
    loop start_loop

    mov     rax,    60  ; SYS_EXIT
    mov     rdi,    0   ; exit code
    syscall

