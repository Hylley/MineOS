#include "headers\debug.h"
#include "headers\idt.h"
#include "headers\isr.h"

extern void kernel()
{
    idt_install();
    isr_install();

    print("Sou lindo");

    return;
}