; Glue code for the emulated environment
RAMSTART	.equ	0x8000
RAMEND		.equ	0xffff
ZASM_CODE	.equ	RAMSTART
ZASM_INPUT	.equ	0xa000
ZASM_OUTPUT	.equ	0xd000

jr	init
init:
	di
	ld	hl, RAMEND
	ld	sp, hl
	ld	hl, ZASM_INPUT
	ld	de, ZASM_OUTPUT
	call	ZASM_CODE
	; signal the emulator we're done
	; BC contains the number of written bytes
	ld	a, b
	out	(c), a
	halt

#include "core.asm"
