strcat:
; rdi = destination str
; rsi = source str

; store dest. in rbx 
mov rbx, rdi

; find end of destination
mov al, 0
.find_end:
	scasb
	jne .find_end
	; rdi is one beyond NUL

; copy src to dest until NUL is reached
.copy_src
	movsb
	cmp byte[rdi - 1], 0
	jne .copy_src

; return, dest stored in rbx
mov rax, rbx
ret



strncat:
; rdi = destination
; rsi = source
; rdx = num of bytes

; copy num of bytes to rcx for loop
mov rcx, rdx

; store dest. in rbx
mov rbx, rdi

; find end of destionation
mov al, 0
.find_end
	scasb
	jne .find_end
	; rdi is one beyond NUL
	
; copy source until NUL reached or num of bytes reached
.copy_src
	movsb
	; check if NUL was copied, break if so
	cmp byte[rdi - 1], 0
	je .end_copy
	
	loop .copy_src

.end_copy
; return, dest stored in rbx
mov rax, rbx
ret



strchr:
; rdi = address of string
; sil = char to search for
; return address of first occurance or nullptr if not found

; store target char in al for string instructions
mov al, sil

; loop over entire str until target char or NUL found
.search_str
	; check if NUL is found
	cmp byte[rdi], 0
	je .not_found

	scasb
	; check if target char if found
	je .found
	jmp .search_str

.not_found
	; return nullptr
	mov rax, 0
	ret

.found
; rdi is one beyond first occurance because scasb increments rdi after checking
dec rdi
mov rax, rdi
ret
