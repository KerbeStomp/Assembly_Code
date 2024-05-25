;;;
;;; hello.s
;;; Prints Hello, world!
;;;
section .data

msg:        db      "Hello, Csci 241!", 10
MSGLEN:     equ     ($ - msg)
SYS_WRITE:  equ     1
STDOUT:     equ     1
SYS_EXIT:   equ     60

section .text

global _start
_start:
    mov     rax,    SYS_WRITE 
    mov     rdi,    STDOUT  
    mov     rsi,    msg    ; Address of string
    mov     rdx,    MSGLEN ; Num of bytes to print. 
    syscall

    mov     rax,    SYS_EXIT
    mov     rdi,    0      ; Exit code (success)
    syscall     
