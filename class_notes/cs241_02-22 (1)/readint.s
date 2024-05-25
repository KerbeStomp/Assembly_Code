readint:
    ; rdi = address
    ; rax = Returned value
    mov rax, 0
    mov rdx, 0
    mov r10, 10
.while:
    mov rsi, 0
    mov sil, byte [rdi]
    cmp sil, ' '
    je .return
    cmp sil, 10
    je .return

    mul r10

    sub sil, '0'
    add rax, rsi

    inc rdi
    jmp .while

.return:
    mov rdx, rdi
    ret