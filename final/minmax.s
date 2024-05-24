; rdi = array address
; rsi = array length, in bytes
; rdx = min pointer
; rcx = max pointer
; r10 = used as counter, keeps track in bytes
; r11 = temp register to hold signed value
; rax = used to store new min/max addr

min_max:
	; set up min and max values from first element in array
	mov rdx, rdi
	mov rcx, rdi
	mov r10, 8

.start_loop
	; go through each element in array
	; check if over array length
	cmp r10, rsi
	jae .end_loop 

	; store current array value
	mov r11, qword[rdi + r10]

	
	; check if current value is below min
	cmp r11, qword[rdx]
	jl .update_min

	; check if current value is above max
	cmp r11, qword[rcx]
	jg .update_max
	
	; if neither are updated, just go to next element	

	; update position in array
	add r10, 8 ; increments by 8 bytes

	jmp .start_loop ; unconditionaly, process next element

.update_min
	; new min address found at rdi + r10; r10 not incremented yet
	mov rax, rdi
	add rax, r10

	; update min pointer
	mov rdx, rax

	; increment r10 to get next element
	add r10, 8

	jmp .start_loop ; process next element

.update_max
	; new max address found  at rdi + r10; r10 not incremented yet
	mov rax, rdi
	add rax, r10

	; update max pointer
	mov rcx, rax

	; increment r10 to get next element
	add r10, 8

	jmp .start_loop ; process next element

.end_loop
	; reset rax before exiting
	mov rax, 0
	ret
