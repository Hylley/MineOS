section .text
	[bits 32]
	[extern _start] ; For some reason, the GCC compiler add a "_" in front of every function it compiles.
	call _start

	jmp $
