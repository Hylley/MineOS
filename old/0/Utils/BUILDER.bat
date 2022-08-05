cd C:\Projects\MineOS\Utils

compile_kernel.bat
compile_kernel_entry.bat
compile_link_kernel.bat
compile_bootloader.bat
concatenate.bat
cd C:\Program Files\qemu
qemu-system-x86_64.exe -drive format=raw file = C:\Projects\MineOS\OS.bin index = , if = floppy -m 1280M
