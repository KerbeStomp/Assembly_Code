section .data

BUFLEN:     equ                20
buffer:     times BUFLEN db    0    ; Buffer of 20 '\0's
newline:    db                 10   ; Single newline

section .text

global _start
_start:

    mov rsi, 1
    mov rdi, 10
    call print_int

    mov rsi, 1
    mov rdi, 186562354
    call print_int

    mov rsi, 1
    mov rdi, 0xdeadbeef12345678         ; = 16045690981402826360 decimal
    call print_int

    ; End program
    mov     rax,  60 
    mov     rdi,  0 
    syscall

print_int:
	; copy loop counter
	mov rcx, BUFLEN

	.start_loop
	; clear div registers
	xor	rdx,	rdx
	xor	rax,	rax

	; store divisor
	mov 	r10, 	10

	; move current value (rdi) into lower div regiser
	mov		rax,	rdi	

	; preform unsigned division to get new dividend (rax) and remainder (rdx)
	div r10

	; convert stored remainder to ASCII value
	add 	dl,		0x30

	; store remainder (rdx) in buffer, using rcx to keep track of placement
	mov		byte[buffer + rcx - 1], 	dl

	; store new dividend (rax) in current value regiser (rdi)
	mov 	rdi,	rax

	; loop back to start, which decrements rcx
	loop .start_loop

	; once out of loop, print value using syscall
	mov		rax,	1
	mov		rdi,	rsi
	mov		rsi,	buffer
	mov		rdx,	BUFLEN
	syscall	

	
; print newline
	mov		rax,	1
	mov		rsi,	newline
	mov 	rdx,	1
	syscall
	

    ret         ; Return from print_int function
