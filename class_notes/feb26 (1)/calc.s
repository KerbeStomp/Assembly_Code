;;;
;;; calc.s
;;;
section .data

jmp_chars:      db      '+',     '-',     '*',     '/',     '%'
jmp_tgts:       dq      case_pl, case_mi, case_tm, case_dv, case_rm
case_count:     equ     ($ - jmp_tgts) / 8

section .text
global _start
_start:
    mov     rdi,    10
    mov     rsi,    7
    mov     dl,     '!'

    ; Switch case starts
    mov     rcx,    0       ; Loop index
begin_do:
    cmp     byte [jmp_chars + rcx], dl ; jmp_chars[rcx]
    je      found

    inc     rcx
    cmp     rcx,    case_count
    jne     begin_do

    ; Not found
    jmp case_default

found:
    ; Found; rcx = index
    mov     rax,    qword [jmp_tgts + 8*rcx] ; rax = addr of case
    jmp     rax

case_pl:
    add     rdi,    rsi
    jmp     end_switch
case_mi:
    sub     rdi,    rsi
    jmp     end_switch
case_tm:
case_dv:
case_rm:
case_default:
    mov     rdi,    0
    jmp     end_switch

end_switch:

    mov     rax,    60
    mov     rdi,    0
    syscall
    
    