#ifndef MEM_H
#define MEM_H

#define FREE_MEM 0x10000;

typedef struct
{
    unsigned short lower_size;
    unsigned short upper_size;
} mem_t;
mem_t memget(void);

void *memset(void *dest, unsigned char val, int count);
void memcp(unsigned char *source, unsigned char *dest, int count);
void initializeMem();
void *kmalloc(int size);
void memcut(int size);
void memreset();
void memrec();
void memunrec();
int getFreeMem();
mem_t memget();

#endif