	.section	.data
M:	.word	1,2,3,4,5,6,7,2,1,10,11,12
p:	.word	0,0,0,0
	
	.section 	.text
	.align 		2
	.global		_start
	
_start:
	ldr	r0, =M
	mov	r12, #12-1
_shiftloop:	
	ldr	r1, [r0]
	lsl	r1, #8
	str	r1, [r0]
	add	r0, #4
	subs	r12, r12, #1
	bne	_shiftloop
	
	ldr	r0, =M
	eor	r12, r12, r12
loop_i:
	mov	r11, r12
	add	r11, r11, #1

	cmp	r11, #3+1
	bge	done
	
loop_j:
	mov	r3, r12  		@ i
	lsl	r3, #2   		@ i*4
	add	r3, r3, r12 		@ i*4+i
	ldr	r3, [r0, r3, lsl #2] 	@ M_{ii}

	mov	r4, r11  		@ j
	lsl	r4, #2   		@ j*4
	add	r4, r4, r12		@ j*4+i
	ldr	r4, [r0, r4, lsl #2] 	@ M_{ji}

	eor	r10, r10, r10
	ldr	r1, =p
loop_k1:
	mov	r2, r12	 		@ i
	lsl	r2, #2   		@ i*4 row
	add	r2, r10	 		@ i*4 + k
	ldr	r2, [r0, r2, lsl #2] 	@ M_{ik}

	muls	r2, r4, r2      	@ M_{ik}*M_{ji} 	16.16
	sdiv	r5, r2, r3      	@ M_{ik}*M_{ji}/M_{ii} 	24.8
	neg	r5, r5			@ negate
	
	str	r5, [r1, r10, lsl #2]

	add	r10, #1
	cmp	r10, #4
	bne	loop_k1

	eor	r10, r10, r10
	ldr	r1, =p
loop_k2:
	mov	r2, r11  		@ j
	lsl	r2, #2			@ j*4
	add	r2, r2, r10 		@ j*4+k	
	ldr	r3, [r0, r2, lsl #2] 	@ M_{jk}
	ldr	r4, [r1, r10, lsl #2] 	@ p_k
	add	r3, r3, r4		@ M_{jk} + p_k

	str	r3, [r0, r2, lsl #2]

	add	r10, #1
	cmp	r10, #4
	bne	loop_k2

	add	r11, #1
	cmp	r11, #3
	bne	loop_j
done:	
	add	r12, #1
	cmp	r12, #3-1
	bne	loop_i

	ldr	r0, =M
	mov	r12, #12
	mov	r5, #1
	lsl	r5, #7
_shiftloop2:	
	ldr	r1, [r0]
	add	r1, r1, r5
	asr	r1, #8
	str	r1, [r0]
	add	r0, #4
	subs	r12, r12, #1
	bne	_shiftloop2
