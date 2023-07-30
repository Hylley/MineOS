# Makefile for compiling the bootloader, kernel, and generating the OS binary

# Define variables for the directories
BIN_DIR := .bin
OBJ_DIR := .obj

# Compiler and linker settings
NASM := nasm
GCC := gcc
LD := ld
OBJCOPY := objcopy

# Define the list of kernel source files
KERNEL_SRC_FILES := \
	kernel/kernel.c \
	kernel/idt.c \
	kernel/isr.c \
	kernel/memory.c \
	kernel/debug.c

# Compile the boot sector
$(BIN_DIR)/bootsector.bin: bootloader/bootsector.asm | $(BIN_DIR)
	@echo ~# Compiling boot sector assembly
	$(NASM) -f bin bootloader/bootsector.asm -o $@

# Compile kernel source files to object files
$(OBJ_DIR)/%.o: $(KERNEL_SRC_FILES)
	@echo ~# Compiling $*
	$(GCC) -ffreestanding -m32 -g -c $< -o $@

# Compile the bridge.asm file to an object file
$(OBJ_DIR)/bridge.o: bootloader/bridge.asm | $(OBJ_DIR)
	$(NASM) bootloader/bridge.asm -f elf -o $@

# Link all object files into a temporary .pe kernel file
$(OBJ_DIR)/kernel.pe: $(OBJ_DIR)/bridge.o $(OBJ_DIR)/kernel_source.o $(OBJ_DIR)/memory.o $(OBJ_DIR)/idt.o $(OBJ_DIR)/isr.o $(OBJ_DIR)/debug.o
	@echo ~# Linking files
	$(LD) -o $@ -Ttext 0x1000 $^

# Convert the temporary .pe file to a full object kernel file
$(BIN_DIR)/kernel.bin: $(OBJ_DIR)/kernel.pe | $(BIN_DIR)
	$(OBJCOPY) -O binary $< $@

# Compile the zeroes assembly file
$(BIN_DIR)/zeroes.bin: bootloader/zeroes.asm | $(BIN_DIR)
	@echo ~# Compiling empty disk space
	$(NASM) bootloader/zeroes.asm -f bin -o $@

# Rule to generate the final OS binary
OS.bin: $(BIN_DIR)/bootsector.bin $(BIN_DIR)/kernel.bin $(BIN_DIR)/zeroes.bin
	@echo ~# Generating OS binary file
	copy /b $(BIN_DIR)/bootsector.bin + $(BIN_DIR)/kernel.bin + $(BIN_DIR)/zeroes.bin $@

# Rule to create the output directories if they don't exist
$(BIN_DIR) $(OBJ_DIR):
	mkdir $@

# Clean up intermediate files and output
clean:
	rm -rf $(BIN_DIR) $(OBJ_DIR) OS.bin

# Declare phony targets to avoid conflicts with file names
.PHONY: clean all

# Define the default target, which will build the OS binary
all: OS.bin
