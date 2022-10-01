#include "header/IDT.h"

#define FLAG_SET(x, flag) x |= flag
#define FLAG_UNSET(x, flag) x &= ~flag

struct IDT_entry
{
    unsigned short base_low;
    unsigned short segment_selector;
    unsigned char reserved; // Always 0;
    unsigned char flags;
    unsigned short base_high;
} __attribute__((packed));

struct IDT_descriptor
{
    unsigned short limit;
    unsigned int base;
} __attribute__((packed));

struct IDT_entry idt[256];
struct IDT_descriptor idtp = { sizeof(idt) - 1, idt};

typedef enum
{
    IDT_FLAG_GATE_TASK = 0x5,
    IDT_FLAG_GATE_16BIT_INT = 0x6,
    IDT_FLAG_GATE_16BIT_TRAP = 0x7,
    IDT_FLAG_GATE_32BIT_INT = 0xE,
    IDT_FLAG_GATE_32BIT_TRAP = 0xF,

    IDT_FLAG_RING0 = (0 << 5),
    IDT_FLAG_RING1 = (1 << 5),
    IDT_FLAG_RING2 = (2 << 5),
    IDT_FLAG_RING3 = (3 << 5),

    IDT_FLAG_PRESENT = 0x80
} IDT_FLAGS;

void IDT_SetGate(unsigned char interrupt, unsigned long base, unsigned short sel, unsigned char flags)
{
    idt[interrupt].base_low = (base & 0xFFFF);
    idt[interrupt].base_high = (base >> 16) & 0xFFFF;

    idt[interrupt].segment_selector = sel;
    idt[interrupt].reserved = 0;
    idt[interrupt].flags = flags;
}    

void IDT_Enable(int interrupt)
{
    FLAG_SET(idt[interrupt].flags, IDT_FLAG_PRESENT);
}

void IDT_Disable(int interrupt)
{
    FLAG_UNSET(idt[interrupt].flags, IDT_FLAG_PRESENT);
}