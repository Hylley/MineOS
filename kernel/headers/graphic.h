#pragma once

#define GRAPHIC_MEMORY 0xA0000
#define GRAPHIC_HEIGHT 200
#define GRAPHIC_WIDTH  320

unsigned int position(int x, int y);
int in_range(int x, int y);

void plot(int position, int color);