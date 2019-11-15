	.section	.text
	.align		2
	.global		_start

_start:
	mov	r0, #3
	bl	_factorial

_end:
	b	_end

_factorial:
	@ The first loop will run till we have counted down the values
	@ each iteration will put the values on the stack
	cmp	r0, #0			@ set zero flag
	moveq	r0, #1			@ if zero return 1
	moveq	pc, lr			@ return if zero
	mov	r1, r0			@ move r0 to r1
	sub	r0, r0, #1		@ subtract 1 from r0

	stmdb	sp!, {r1,lr}		@ store the link and r1 on the stack
	
	bl	_factorial		@ branch with link to start

	@ If we reach this point we called the routine with a non-zero value and
	@ the r0 is now 0
	ldmia	sp!, {r1,lr}
	mul	r0, r1, r0		@ r0 = r0*r1

	mov	pc, lr			@ if stack is not back to start, jump to bl line+4
	                                @ if stack back to start jump out of factorial
