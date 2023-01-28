@echo off

@echo ~# Running...
qemu-system-x86_64 -drive file=OS.bin,format=raw,index=0,if=floppy,  -m 128M