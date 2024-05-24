section .data

zero:   dq      0.0
one:    dq      1.0
two:    dq      2.0
four:   dq      4.0
negone: dq      -1.0
limit:  dq      0.000001

format: db      "%f", 10, 0

section .text

extern printf

global main
main:

    push rbp
    mov rbp, rsp

    ;; Compute pi 
    movsd xmm0, qword [limit]   
    call compute_pi
    ; Return value in xmm0  

    ;; Print result
    mov rdi, format
    mov al, 1
    call printf

    mov rax, 0
    pop rbp
    ret

compute_pi:
    push rbp
    mov rbp, rsp

	; set up const registers (xmm6-10)
	movsd	xmm6,	qword[zero]
	movsd	xmm7,	qword[one]
	movsd	xmm8,	qword[two]
	movsd	xmm9,	qword[four]
	movsd	xmm10,	qword[negone]

	; set up operating registers (xmm1-3)
	; xmm1 used for running value
	movsd	xmm1,	xmm6

	; xmm2 used for sign
	movsd	xmm2,	xmm7

	; xmm3 used for counter
	movsd	xmm3,	xmm6

.begin_loop:
	; store first denominator (2i+2) in xmm4
	movsd	xmm4,	xmm3
	mulsd	xmm4,	xmm8
	addsd	xmm4,	xmm8

	; compute second denominator (2i+3) in xmm5
	; by copying first denom. from xmm4 + 1
	; then multiply with xmm4
	movsd	xmm5,	xmm4
	addsd	xmm5,	xmm7
	mulsd	xmm4,	xmm5

	; compute third denominator (2i+4) in xmmr5
	; by adding 1 to second denom. in xmm5
	; then multiply  xmm4
	addsd	xmm5,	xmm7
	mulsd	xmm4,	xmm5

	; compute current value in xmm5
	movsd	xmm5,	xmm9
	mulsd	xmm5,	xmm2
	divsd	xmm5,	xmm4

	; add current value to running value
	addsd	xmm1,	xmm5

	; update sign
	mulsd	xmm2,	xmm10

	; increment counter
	addsd	xmm3,	xmm7

	; compute denominator accuracy
	vdivsd	xmm5,	xmm9,	xmm4

	; compare with limit and jump if necessary
	ucomisd		xmm5,	xmm0
	ja	.begin_loop

	movsd	xmm0,	xmm1

	; once out of loop, add 3 to running value
	addsd	xmm0,	xmm7
	addsd	xmm0,	xmm8
	
	pop rbp
	ret
