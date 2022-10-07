@echo off

if not exist ".bin\" mkdir ".bin"
if not exist ".obj\" mkdir ".obj"

@echo - Compiling boot sector...
nasm bootloader\boot.asm -f bin -o .bin\boot_sector.bin

@echo - Compiling kernel...
gcc -ffreestanding -m32 -g -c kernel\kernel.c -o .obj\kernel.o
nasm bridge\kernel_bridge.asm -f elf -o .obj\kernel_entry.o
ld -o .obj\kernel.pe -Ttext 0x1000 .obj\kernel_entry.o .obj\kernel.o
objcopy -O binary .obj\kernel.pe .bin\kernel.bin
nasm bridge\filler.asm -f bin -o .bin\filler.bin

@echo - Creating OS .binary file...
copy /b .bin\boot_sector.bin + .bin\kernel.bin + .bin\filler.bin OS.bin

@echo - Executing...
qemu-system-x86_64 OS.bin
