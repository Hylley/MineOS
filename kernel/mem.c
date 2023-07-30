#include "headers\mem.h"

char* data_segment_base;
char* data_segment_head;
void init_mem()
{
	asm("movl %%ds, %0" : "=r" (data_segment_base));
	data_segment_head = data_segment_base;
}

char* alloc(unsigned int size)
{
	char* result = data_segment_head;
	data_segment_head = data_segment_head + size;

	return result;
}