cd C:\Projects\MineOS
ld -o "full_kernel.bin" -Ttext 0x1000 "kernel_entry.o" --oformat binary
