; notes for 5-15
bits 16 ; writing in 16-bit code
org 0x7c00

; boot code
mov ah, 0x0 ; subfunction 0 = set video mode
mov al, 0x3 ; video mode 3 = 80x25 text mode
int 0x10 ; interrupt 0x10 (16) = video related functions

; loop over string until NUL
mov di, 0 ; string index
begin_loop:
	cmp byte[msg + di] ; char to print
	;mov bh, 0 ; page number
	mov bx, di
	mov bh, 0
	mov cx, 1 ; number of copies
	int 0x10

	inc di

	;move cursor
	mov ah, 0x2 ; subfunction 2 = move cursor
	mov bh, 0 ; page number
	mov dx, di ; dl = X-coord
	mov dh, 0 ; Y-coord = 0
	int 0x10

	jmp begin_loop
	
; forever loop
forever: jmp forever


; data section
msg: db "Hello, world!", 0
;pad to 512 bytes
times 510 - ($ - $$) db 0

; signature
dw 0xaa55