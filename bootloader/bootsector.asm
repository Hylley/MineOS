;  Memory addresses are not counted from 0 by the assembler, since the
; bootsector code actually starts at 0x7c00. By creating tags or
; functions far enough away from where you are calling them, you may
; end up executing the wrong code, causing undefined behavior. It is
; wise to use that as an absolute address as "offset" to resolve the
; real memory address.
[org 0x7c00]

; / --- Startup -----------------------------------------------------/
KERNEL_LOCATION equ 0x1000
mov [BOOT_DISK], dl ; "BOOT_DISK" constant is defined moreafter.

; / --- Read --------------------------------------------------------/
; This pack of code reads content of the disk at the kernel location.
xor ax, ax
mov es, ax
mov ds, ax
mov bp, 0x8000
mov sp, bp
mov bx, KERNEL_LOCATION
mov dh, 20
mov ah, 0x02
mov al, dh
mov ch, 0x00
mov cl, 0x02
mov dh, 0x00
mov dl, [BOOT_DISK]
int 0x13

; Enter teletype mode to clean the screen
mov ah, 0x0
mov al, 0x3
int 0x10

; / --- Protected mode ----------------------------------------------/
; Sets up the 32-bit protected mode.

cli ; Disable all BIOS fucntions.

%include "bootloader\\GDT.asm" ; Load the GDT
%include "bootloader\\protected_mode.asm" ; Sets up the protected mode
;											(if you remove this part the
;								 			OS continues in real-mode)

jmp $ ; In case of errors, stuck the screen.

BOOT_DISK: ; BOOT_DISK constant
	db 0x00

; Any valid bootsector need to have 5120 complete bytes. This line
; fill the avaliable rest space of the boot sector with 0es until it
; complete 510 total bytes. The other 2 bytes are right down there.
times 510 - ($ - $$) db 0

; The 0xAA55 signature has to be the last two bytes of the first
; sector of the boot disk. The BIOS need it to know that it's actually
; a valid bootable system. If it wasn't here, the BIOS would raise an
; error saying it didn't find any bootable disk.
db 0x55, 0xaa