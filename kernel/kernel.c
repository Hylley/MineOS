#include "kernel.h"
#include "utils\types.h"

#include "drivers\vga\graphics.c"
#include "cpu\interrupts\idt.c"

extern void start()
{
    
}

extern void kpanic(struct regs *r)
{
    return;
}