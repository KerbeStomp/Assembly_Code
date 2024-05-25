;;;
;;; echo.s
;;; Echoes stdin to stdout
;;;
section .data

BUFLEN:     equ     256
buffer:     times BUFLEN db 0

SYS_READ:   equ     0
STDIN:      equ     0
SYS_WRITE:  equ     1
STDOUT:     equ     1
SYS_EXIT:   equ     60

section .text

global _start
_start:
    ; Sys read to get input
    mov     rax,    SYS_READ
    mov     rdi,    STDIN
    mov     rsi,    buffer
    mov     rdx,    BUFLEN
    syscall
    
    ; Sys write to print it out
    mov     rdx,    rax
    mov     rax,    SYS_WRITE
    mov     rdi,    STDOUT
    mov     rsi,    buffer
    syscall

    ; Sys exit
    mov     rax,    SYS_EXIT
    mov     rdi,    0
    syscall





    