;;;
;;; uppercase.s
;;;
section .data

string:    db      "The Cat in the Hat.", 0

section .text

global _start
_start:
    mov     rdi,     string

begin_while:
    cmp     byte [rdi], 0
    je      end_while

    ; Not at end of string
    ;cmp     byte [rdi], 'a'
    ;jnae    endif
    ;cmp     byte [rdi], 'z'
    ;jnbe    endif
    cmp     byte [rdi], 'a'
    setae   al
    cmp     byte [rdi], 'z'
    setbe   bl
    and     al,     bl          ; al = al AND bl

    jz      endif

    ; *rdi >= 'a' and *rdi <= 'z'
    sub byte [rdi], ('a' - 'A')

endif:
    inc     rdi
    jmp     begin_while

end_while:

    sub     rdi,    string
    mov     rdx,    rdi     ; String length
    
    mov     rax,    1
    mov     rdi,    1
    mov     rsi,    string
    syscall

    mov     rax,    60
    mov     rdi,    0
    syscall
    
    