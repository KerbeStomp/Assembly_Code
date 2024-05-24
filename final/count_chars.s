; rdi = NUL terminated string addr.
; r10 = used as string pos.
; r11 = used to store char value
; rax = counter

count_chars:

	; set up counter
	mov rax, 0
	
	; set up rsi to use stosb instruction
	mov rsi, rdi	

.start_loop
	; get character from string
	lodsb ; char to process stored in al

	; check if pulled char is null terminating 0
	cmp al, 0
	je .end_loop

	; check if pulled char is witin ASCII range for digits (48 - 57)
	cmp al, 48
	jnae .start_loop ; continue if ASCII value less than 48 (ASCII digit 0)
	cmp al, 57
	jnbe .start_loop ; continue if ASCII value more than 57 (ASCII digit 9)

	inc rax ; increment counter once ASCII digit found

	jmp .start_loop ; unconditionally go to next char

.end_loop
	; counter value already kept in rax
	ret
