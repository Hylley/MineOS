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
mov al, 0x13
int 0x10	 ; Enter 256-color mode and clear the screen.

mov ah, 0x0
mov al, 0x13
int 10h
mov cx, 10
mov dx, 240
mov ax, 0C02h

back: int 0x10
	inc cx
	cmp cx, 50
	jb back

BOOT_DISK: db 0

;	End of bootloader

times 510-($-$$) db 0 ; Fill the rest free space with zeroes to reach 510 bytes...
dw 0xaa55			  ; ...and end with the boot magic number, withco fill the remaning 2 bytes.
