#include "header/kernel.h"

extern void kernel()
{
	int background_color = 0;
	int line_color = 15;

	int point1[] = {SCREEN_WIDTH/2, SCREEN_HEIGHT/2};
	int point2[] = {0, 0};

	while(1)
	{
		fill(background_color);
		point2[0] += 1;
		point2[1] += 1;
		draw_line(point1, point2, line_color);
	}

	return;
}
