[bits 32]
protected_mode:
    ; Segments registers and stack setup;
    mov ax, DATA_SEG
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ebp, 0x90000
    mov esp, ebp

    mov eax, DATA_SEG

    ; Jump to kernel.
    jmp KERNEL_LOCATION