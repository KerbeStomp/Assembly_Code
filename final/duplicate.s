has_duplicate_pair:
; rdi = qword array address
; rsi = length, assuming number of elements
; r10 = current position in array
; r11 = next  position in arrray
; rax = temp register for array value

	; check if at least two elements exist
	cmp rsi, 2
	jb .no_dupe_pair
	
	; set up array position
	mov r10, 0
	mov r11, 1

.check_array:
	; check if the two elements are equal
	mov rax, qword[rdi + r10 * 8] ; store left value for comparison
	cmp qword[rdi + r11 * 8], rax
	je .has_dupe_pair

	; increment array positions
	inc r10
	inc r11

	; check if last pair was checked
	; r11 should be one beyond array length
	cmp r11, rsi
	jae .no_dupe_pair

	; unconditionally jump back to start of loop
	jmp .check_array

.has_dupe_pair:
	; pair dupelicate found, return 1 in rax
	mov rax, 1
	ret

.no_dupe_pair:
	; no pair duplicate found, return 0 in rax
	mov rax, 0
	ret
