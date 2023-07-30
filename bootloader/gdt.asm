; "equ" is used to define constants and capslock is the convention.
CODE_SEG equ code_descritor - GDT
DATA_SEG equ data_descritor - GDT

lgdt[GDT_descriptor]

; This pack of code change the last bit of cr0 to 1. Since it can't be
; changed directly, we need to pass the value of a general purpose
; register.
mov eax, cr0
or eax, 1
mov cr0, eax

; The "far jump" is a jump to another segment wich activates the 32
; bit protected mode.
jmp CODE_SEG:protected_mode
jmp $ ; In case of errors.

GDT:
    ; At the beginning of every GDT there's must be an empty
	; descriptor with eight null (0) bytes.
    null_descriptor:
        dd 0
        dd 0
    
    code_descritor:
        ; The limit of our descriptor, 0xf is the maximum value;
        dw 0xffff

        ; 16 bits (define word - dw) + 8 bits (define byte - db) = 24
		; bits of the base.
        dw 0
        db 0

        ; Presence, privilege and type and type flags.
        db 10011010b

        ; Other flags + limit (last 4 bits).
        db 11001111b

        ; Last 8 bits.
        db 0
    
    data_descritor:
        dw 0xffff
        dw 0
        db 0
        db 10010010b
        db 11001111b
        db 0
    
    gdt_end:

GDT_descriptor:
    ; Set the full size of the GDT.
    dw gdt_end - GDT - 1

    ; Set the beginning of the GDT.
    dd GDT