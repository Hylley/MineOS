[bits 32]
[extern _kernel]
call _kernel

jmp $ ; In case of errors

; Activate the IDT mapping, a small extension of the IDT C file at kernel.
; %include "bootloader\\IDT.asm"
; %include "bootolader\\IRQ.asm"

; Here is the definition of our BSS section. Right now, we'll use
; it just to store the stack. Remember that a stack actually grows
; downwards, so we declare the size of the data before declaring
; the identifier '_sys_stack'
; SECTION .bss
;     resb 8192               ; This reserves 8KBytes of memory here
; _sys_stack: