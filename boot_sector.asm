[org 0x7c00]	; Start from the "0x7c00" memory location.

KERNEL_LOCATION equ 0x1000
; "equ" is used to set constants.

mov [BOOT_DISK], dl

xor ax, ax
mov es, ax
mov ds, ax
mov bp, 0x8000
mov sp, bp

mov bx, KERNEL_LOCATION
mov dh, 2

mov ah, 2
mov al, dh
mov ch, 0x00
mov dh, 0x00
mov cl, 0x02
mov dl, [BOOT_DISK]
int 0x13

mov ah, 0x0
mov al, 0x3
int 0x10	; Enter text mode to clear the screen.

CODE_SEG equ code - GDT_Start ; The offset of the code segment.
DATA_SEG equ data - GDT_Start ; The offset of the data segument.

cli ; Disable all BIOS interrupts.
lgdt[GDT_Descriptor]

mov eax, cr0 ;		Change last bit of cr0 to 1 to complete the switch to 32 bit.
mov eax, 1	 ; (Since we cannot change it directly, we need to use a register,
mov cr0, eax ; asign the value and then change it indirectly).

jmp CODE_SEG:start_protected_mode ; Far jump.

jmp $	; In case far jump fails.

BOOT_DISK: db 0

;						Global Descriptor Table (GDT)

GDT_Start:
	null:
		dd 0x0
		dd 0x0

	code:
		dw 0xffff	 ; Limit of size (at this case, maximum);
		dw 0x0		 ; Base address, 16 bits ...
		db 0x0		 ; + 8 bits = 24 bits;
		db 0b10011010 ; Present, privelege and type propeties + type flags;
		db 0b11001111 ; Other flags + limit (last four bits);
		db 0x0		 ; Last 8 bits of the base.

	data:
		dw 0xffff	 ; Limit of size (at this case, maximum);
		dw 0x0		 ; Base address, 16 bits ...
		db 0x0		 ; + 8 bits = 24 bits;
		db 0b10010010 ; Present, privelege and type propeties + type flags;
		db 0b11001111 ; Other flags + limit (last four bits);
		db 0x0		 ; Last 8 bits of the base.

GDT_End:

GDT_Descriptor:
	dw GDT_End - GDT_Start - 1 ; Size of the GDT;
	dd GDT_Start			   ; Pointer to the beggining of the GDT;

;								Protected mode

[bits 32]
start_protected_mode:
	mov ax, DATA_SEG
	mov ds, ax
	mov ss, ax
	mov es, ax
	mov fs, ax
	mov gs, ax

	mov ebp, 0x90000		; 32 bit stack base pointer
	mov esp, ebp

	jmp KERNEL_LOCATION

	jmp $	; In case some error occur.

;							End of bootloader

times 510-($-$$) db 0 ; Fill the rest free space with zeroes to reach 510 bytes...
dw 0xaa55			  ; ...and end with the boot magic number, withco fill the remaning 2 bytes.
