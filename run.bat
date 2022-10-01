@echo off

cd C:\Projects\MineOS

@echo - Compiling boot sector...
nasm boot_sector_pm.asm -f bin -o binaries\boot_sector.bin

@echo - Compiling kernel...
gcc -ffreestanding -m32 -g -c kernel\kernel.c -o objects\kernel.o
nasm kernel_entry.asm -f elf -o objects\kernel_entry.o
ld -o objects\kernel.pe -Ttext 0x1000 objects\kernel_entry.o objects\kernel.o
objcopy -O binary objects\kernel.pe binaries\kernel.bin

@echo - Creating OS binary file...
copy /b binaries\boot_sector.bin + binaries\kernel.bin + binaries\zeroes.bin OS.bin

@echo - Executing...
qemu-system-x86_64 OS.bin
