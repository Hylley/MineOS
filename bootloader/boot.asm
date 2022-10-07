[org 0x7C00] ; Set the origin to 0x7C00;
[bits 16]

KERNEL_LOCATION equ 0x7ef0

_main16:
	;save boot disk number
	mov [BOOT_DISK], dl

	;set up segment registers
	cli
	mov ax, 0x00
	mov ds, ax
	mov es, ax
	mov ss, ax
	mov sp, 0x7C00
	sti
    
	call memory_detection
    call upper_memory_detection

	;read 50 sectors at kernel location
	mov bx, KERNEL_LOCATION
	mov dh, 50
	call disk_read

    ;clear the screen
	mov ah, 0x00
	mov al, 0x13
	int 0x10

	jmp enter_protected_mode

; --------------------------

%include"bootloader\\error.asm" ; Some cool debug functions.
%include"bootloader\\disk.asm" ; Disk managment.
%include"bootloader\\memory.asm" ; old memory detection code
%include"bootloader\\protected_mode.asm" ; Enter protected 32-bit mode.
%include"bootloader\\gdt.asm" ; Use the global descriptor table.

; --------------------------

[bits 32]

_main32:
	;set up segment registers again
	mov ax, DATA_SEG
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov ss, ax

	;set up the stack
	mov ebp, 0x90000
	mov esp, ebp
	
	;enable the A20 line
	in al, 0x92
	or al, 0x02
	out 0x92, al

	;jump to kernel
	jmp KERNEL_LOCATION
	

times 510-($-$$) db 0x00    ; Fill the remaining bits to 0 until fill 512 bytes.
dw 0xAA55