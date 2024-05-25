;;; hello-mem.s
;; Prints Hello, world! to VRAM

bits 16
org 0x7c00

;; begin bootloader code

	;set 80x25 text mode
	mov ah, 0x0 ; subfunction 0 = set video mode
	mov al, 0x3 ; Mode 3 = 80x25 test mode
	int 0x10

	; setup segment to point to VRAM (0xb8000)
	mov ax, 0xb8000 / 16
	mov fs, ax

	mov di, msg ; Addr in string
	mov bx, 0 ; Addr in VRAM
begin_loop:
	mov al, byte[di] ; from data segment
	cmp al, 0
	je forever

	; Write char to VRAM
	mov byte[fs:bx], al ; Char (ASCII) ; fs * 16 + bx ;; fs = 0xb8000/16 ;; 0xb8000 + bx
	mov byte[fs:bx + 1], 0x0f ; Attr

	inc di
	add bx, 2
	jmp begin_loop

	forever: jmp forever

;; ===== Data Section =====

msg: db "Hello, world!", 0

;; ==== End MBR ====

; pad to 510 bytes with 0s
times 510 - ($ - $$) db 0 ; fills remaining space with 0s

; signature bytes
dw 0xaa55