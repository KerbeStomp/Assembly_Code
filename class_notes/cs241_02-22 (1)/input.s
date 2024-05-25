;;;
;;; input.s
;;;
section .data

BUFLEN:     equ             256
buffer:     times BUFLEN    db '#'

SYS_WRITE:  equ             1
SYS_READ:   equ             0
STDOUT:     equ             1
STDIN:      equ             0
SYS_EXIT:   equ             60

section .text

global _start
_start:

    mov     rax,    SYS_READ
    mov     rdi,    STDIN
    mov     rsi,    buffer
    mov     rdx,    BUFLEN
    syscall

    mov     rdx,    rax     
    mov     rax,    SYS_WRITE
    mov     rdi,    STDOUT
    mov     rsi,    buffer
    syscall

    mov     rax,    SYS_EXIT
    mov     rdi,    0
    syscall
    









    
    