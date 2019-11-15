	.section	.text
	.align		2
	.global		_start

_start:
	mov	r0, #42
	ldr	r1, =_start
	ldr	r2, [r1]
	mov	r3, r2
	add	r2, r2, #0x01
	mov	r4, #0x0000fff
	and	r2, r2, r4  @ mask out operand 2
	orr	r3, r3, r2
	str	r3, [r1]
	b	_start
