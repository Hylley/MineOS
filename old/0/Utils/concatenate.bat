cd C:\Projects\MineOS
COPY /B boot.bin + full_kernel.bin final_result.bin
COPY /B final_result.bin + security_zeroes.bin OS.bin
