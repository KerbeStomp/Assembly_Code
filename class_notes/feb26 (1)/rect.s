;;;
;;; rect.s
;;;
section .data

buffer:     times 10000 db 0

section .text
global _start
_start:
    mov     rdi,    16     ; Width
    mov     rsi,   13    ; Height

    mov     r8,     rdi    ; Width
    mov     r9,     rsi   ; Height
    mov     r12,    0     ; Outer loop var
    mov     r13,    0     ; Inner loop var
    mov     rcx,    buffer
outer:
    mov     r13,    0
inner:
    mov     byte [rcx], '*'
    inc     rcx

    inc     r13
    cmp     r13,    r8
    jl      inner

    mov     byte [rcx], 10
    inc     rcx
    
    inc     r12
    cmp     r12,    r9
    jl      outer

    mov     rdx,    rcx ; Num. of bytes to print
    sub     rdx,    buffer ; Get length of buffer
    mov     rax,    1
    mov     rdi,    1
    mov     rsi,    buffer
    syscall

    mov     rax,    60
    mov     rdi,    0
    syscall
    