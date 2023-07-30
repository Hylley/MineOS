@echo off
if not exist ".bin\" mkdir ".bin"
if not exist ".obj\" mkdir ".obj"

:: Compile boot sector
@echo ~# Compiling boot sector assembly
nasm -f bin bootloader\bootsector.asm -o .bin\bootsector.bin

:: Compile kernel
@echo ~# Compiling kernel files and bridging bootloader

:: Compile all kernel source files to an object file. This is necessary to link it
:: to the bridge assembly file.
gcc -ffreestanding -m32 -g -c kernel\kernel.c -o .obj\kernel_source.o       &:: This is the main kernel source file
gcc -ffreestanding -m32 -g -c kernel\graphic.c -o .obj\graphic.o
gcc -ffreestanding -m32 -g -c kernel\random.c -o .obj\random.o
gcc -ffreestanding -m32 -g -c kernel\time.c -o .obj\time.o
gcc -ffreestanding -m32 -g -c kernel\math.c -o .obj\math.o
gcc -ffreestanding -m32 -g -c kernel\mem.c -o .obj\mem.o

:: Compile the bridge.asm file also to an object file.
nasm bootloader\bridge.asm -f elf -o .obj\bridge.o

@echo ~# Linking files
:: Then link all .obj files into one temporary .pe kernel file, so only then...
ld -o .obj\kernel.pe -Ttext 0x1000^
    .obj\bridge.o^
    .obj\kernel_source.o^
    .obj\graphic.o^
    .obj\random.o^
    .obj\time.o^
    .obj\math.o^
    .obj\mem.o

:: ...convert into a full object kernel file (idk why, but ld only works this way in my machine)
objcopy -O binary .obj\kernel.pe .bin\kernel.bin

@echo ~# Piecing together

:: Compile the zeroes assembly file (to prevent disk errors in the future)
if not exist ".bin\zeroes.bin" @echo ~# Compiling empty disk space & nasm bootloader\zeroes.asm -f bin -o .bin\zeroes.bin

:: Finaly, the full OS binary.
@echo ~# Generatinh OS binary file
copy /b .bin\bootsector.bin + .bin\kernel.bin + .bin\zeroes.bin OS.bin

IF NOT "%1."=="." run.bat