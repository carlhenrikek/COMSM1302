	.section	.text
	.align		2
	.global		_start

_start:
	ldr	r0, =data
	bl	_largest

	mov	r0, r2
	swi	0x11

	
_end:	b	_end

_largest:
	eor	r1,r1,r1		@ clear registers
	eor	r2,r2,r2
	eor	r3,r3,r3
_loop:
	ldr	r1, [r0,r3,lsl #2]	@ read data
	cmp	r1, #0			@ test if zero
	moveq	pc, lr			@ if zero return i.e last value
	cmp	r2,r1			@ set flags
	movlt	r2,r1			@ update new value
	add	r3, #1			@ next point
	b	_loop
	
data:	.word	0x1234,0x3022,0x1233,0x1020,0x5055,0x1203,0x0000
