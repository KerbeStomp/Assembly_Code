has_duplicates:
; rdi = array addr.
; rsi = num. of elems.
mov r10, 0

.outer_loop
cmp r10, rsi
je .no_dupes

mov r11, r10
inc r11

mov r12, qword[rdi + r10 * 8]

.inner_loop
cmp r11, rsi
je .end_inner

cmp qword[rdi + r11 * 8], r12
je .has_dupes
inc r11
jmp .inner_loop

.end_inner
inc r10
jmp .outer_loop

.no_dupes
mov rax, 0
ret

.has_dupes
mov rax, 1
ret
