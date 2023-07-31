#include "headers\graphic.h"

unsigned int position(int x, int y)
{
	return GRAPHIC_WIDTH * y + x;
}

int in_range(int x, int y)
{
	return x > 0 && x < GRAPHIC_WIDTH && y > 0 && y < GRAPHIC_HEIGHT;
}

void plot(int position, int color)
{
	unsigned char *location =(unsigned char*)GRAPHIC_MEMORY + position;
	*location  = color;
}

unsigned int grab(int position)
{
	return *(unsigned char*)GRAPHIC_MEMORY + position;
}

unsigned int safe_grab(int x, int y)
{
	if(!in_range(x, y))
		return 0;
	
	return grab(position(x, y));
}