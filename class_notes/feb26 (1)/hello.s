











section .data

msg:    db      "Hello, CSci 241!", 10
MSGLEN: equ     ($ - msg)

section .text

global _start
_start:
    mov     rax,    1          ; rax = 1            -> Syscall Code (1 = SYS_WRITE)
    mov     rdi,    1          ; rdi = 1            -> Output stream (fd) (1 = stdout)
    mov     rsi,    msg        ; rsi = msg (addr)   -> Addr of string
    mov     rdx,    MSGLEN     ; rdx = MSGLEN (14)  -> Len of string
    syscall

_exit:
    mov     rax,    60         ;                    -> (60 = SYS_EXIT)
    mov     rdi,    0          ;                    -> exit code (return 0)
    syscall

    
    
