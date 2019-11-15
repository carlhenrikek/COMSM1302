	.section	.text
	.global		_start
	.align		4

_start:	
	mov	r0, #10
	bl	_fibonacci

_end:	b	_end



_fibonacci:
	stmdb	sp!, {r1-r3}
        mov   r1,  #0
        mov   r2,  #1
 
_fibloop:
        mov   r3,  r2
        add   r2,  r1,  r2
        mov   r1,  r3
        sub   r0,  r0,  #1
        cmp   r0,  #1
        bne   _fibloop
 
        mov   r0,  r2
	ldmia	sp!, {r1-r3}
        mov   pc,  lr
