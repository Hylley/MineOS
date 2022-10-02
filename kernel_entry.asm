[bits 32]

; INTERRUPT DESCRIPTOR TABLE

[extern _idtp]
lidt[_idtp]


; KERNEL START

[extern _kernel] ; For some reason, the GCC compiler add a "_" in front of every function it compiles.
call _kernel


jmp $