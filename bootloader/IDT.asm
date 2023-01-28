; Loads the IDT defined in '_idtp' into the processor.
; This is declared in the idt C header file (in kernel folder) as 'extern void idt_load();', give it a look
global _idt_load
extern _idtp
_idt_load:
    lidt [_idtp]
    ret

; %assign i 0 ; Need some work!
; %rep 32
;     global_isr + %[i]
; %assign i i + 1
; %endrep

global _isr0
global _isr1
global _isr2
global _isr3
global _isr4
global _isr5
global _isr6
global _isr7
global _isr8
global _isr9
global _isr10
global _isr11
global _isr12
global _isr13
global _isr14
global _isr15
global _isr16
global _isr17
global _isr18
global _isr19
global _isr20
global _isr21
global _isr22
global _isr23
global _isr24
global _isr25
global _isr26
global _isr27
global _isr28
global _isr29
global _isr30
global _isr31

; Division by zero exception
_isr0:
    cli
    push byte 0
    push byte 0
    jmp isr_common_stub

;  Debug exception
_isr1:
    cli
    push byte 0
    push byte 1
    jmp isr_common_stub

;  Non maskable interrupt exception
_isr2:
    cli
    push byte 0
    push byte 2
    jmp isr_common_stub

; Int 3
_isr3:
    cli
    push byte 0
    push byte 3
    jmp isr_common_stub

; INTO
_isr4:
    cli
    push byte 0
    push byte 4
    jmp isr_common_stub

; Out of Bounds
_isr5:
    cli
    push byte 0
    push byte 5
    jmp isr_common_stub

; Invalid Opcode
_isr6:
    cli
    push byte 0
    push byte 6
    jmp isr_common_stub

; Coprocessor Not Available
_isr7:
    cli
    push byte 0
    push byte 7
    jmp isr_common_stub

; Double fault (with error code!)
_isr8:
    cli
    push byte 8
    jmp isr_common_stub

; Coprocessor segment overrun
_isr9:
    cli
    push byte 0
    push byte 9
    jmp isr_common_stub

; Bad TSS (with error code)
_isr10:
    cli
    push byte 10
    jmp isr_common_stub

; Segment not present (with error code)
_isr11:
    cli
    push byte 11
    jmp isr_common_stub

; Stack fault (with error code)
_isr12:
    cli
    push byte 12
    jmp isr_common_stub

; General protection fault (with error code)
_isr13:
    cli
    push byte 13
    jmp isr_common_stub

; Page fault (with error code)
_isr14:
    cli
    push byte 14
    jmp isr_common_stub

; Reserved Exception
_isr15:
    cli
    push byte 0
    push byte 15
    jmp isr_common_stub

; Floating Point
_isr16:
    cli
    push byte 0
    push byte 16
    jmp isr_common_stub

; Alignment Check
_isr17:
    cli
    push byte 0
    push byte 17
    jmp isr_common_stub

; Machine Check
_isr18:
    cli
    push byte 0
    push byte 18
    jmp isr_common_stub

; The rest are reserved

_isr19:
    cli
    push byte 0
    push byte 19
    jmp isr_common_stub

_isr20:
    cli
    push byte 0
    push byte 20
    jmp isr_common_stub

_isr21:
    cli
    push byte 0
    push byte 21
    jmp isr_common_stub

_isr22:
    cli
    push byte 0
    push byte 22
    jmp isr_common_stub

_isr23:
    cli
    push byte 0
    push byte 23
    jmp isr_common_stub

_isr24:
    cli
    push byte 0
    push byte 24
    jmp isr_common_stub

_isr25:
    cli
    push byte 0
    push byte 25
    jmp isr_common_stub

_isr26:
    cli
    push byte 0
    push byte 26
    jmp isr_common_stub

_isr27:
    cli
    push byte 0
    push byte 27
    jmp isr_common_stub

_isr28:
    cli
    push byte 0
    push byte 28
    jmp isr_common_stub

_isr29:
    cli
    push byte 0
    push byte 29
    jmp isr_common_stub

_isr30:
    cli
    push byte 0
    push byte 30
    jmp isr_common_stub

_isr31:
    cli
    push byte 0
    push byte 31
    jmp isr_common_stub

; We will call a C function here. We need to let the assembler know
; that '_fault_handler' exists in another file
[extern _fault_handler]

; This is our common ISR stub. It saves the processor state, sets
; up for kernel mode segments, calls the C-level fault handler,
; and finally restores the stack frame.
isr_common_stub:
    pusha
    push ds
    push es
    push fs
    push gs
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov eax, esp
    push eax
    mov eax, _fault_handler
    call eax
    pop eax
    pop gs
    pop fs
    pop es
    pop ds
    popa
    add esp, 8
    iret

; global _irq0
; global _irq1
; global _irq2
; global _irq3
; global _irq4
; global _irq5
; global _irq6
; global _irq7
; global _irq8
; global _irq9
; global _irq10
; global _irq11
; global _irq12
; global _irq13
; global _irq14
; global _irq15

; _irq0:
;     cli
;     push byte 0
;     push byte 32
;     jmp irq_common_stub

; _irq1:
;     cli
;     push byte 0
;     push byte 33
;     jmp irq_common_stub

; _irq2:
;     cli
;     push byte 0
;     push byte 34
;     jmp irq_common_stub

; _irq3:
;     cli
;     push byte 0
;     push byte 35
;     jmp irq_common_stub

; _irq4:
;     cli
;     push byte 0
;     push byte 36
;     jmp irq_common_stub

; _irq5:
;     cli
;     push byte 0
;     push byte 37
;     jmp irq_common_stub

; _irq6:
;     cli
;     push byte 0
;     push byte 38
;     jmp irq_common_stub

; _irq7:
;     cli
;     push byte 0
;     push byte 39
;     jmp irq_common_stub

; _irq8:
;     cli
;     push byte 0
;     push byte 40
;     jmp irq_common_stub

; _irq9:
;     cli
;     push byte 0
;     push byte 41
;     jmp irq_common_stub

; _irq10:
;     cli
;     push byte 0
;     push byte 42
;     jmp irq_common_stub

; _irq11:
;     cli
;     push byte 0
;     push byte 43
;     jmp irq_common_stub

; _irq12:
;     cli
;     push byte 0
;     push byte 44
;     jmp irq_common_stub

; _irq13:
;     cli
;     push byte 0
;     push byte 45
;     jmp irq_common_stub

; _irq14:
;     cli
;     push byte 0
;     push byte 46
;     jmp irq_common_stub

; _irq15:
;     cli
;     push byte 0
;     push byte 47
;     jmp irq_common_stub

; extern _irq_handler

; irq_common_stub:
;     pusha
;     push ds
;     push es
;     push fs
;     push gs

;     mov ax, 0x10
;     mov ds, ax
;     mov es, ax
;     mov fs, ax
;     mov gs, ax
;     mov eax, esp

;     push eax
;     mov eax, _irq_handler
;     call eax
;     pop eax

;     pop gs
;     pop fs
;     pop es
;     pop ds
;     popa
;     add esp, 8
;     iret

; Here is the definition of our BSS section. Right now, we'll use
; it just to store the stack. Remember that a stack actually grows
; downwards, so we declare the size of the data before declaring
; the identifier '_sys_stack'
SECTION .bss
    resb 8192               ; This reserves 8KBytes of memory here
_sys_stack: