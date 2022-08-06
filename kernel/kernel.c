#include "header/kernel.h"

extern void start()
{
	int background_color = 0;
	int line_color = 15;

	int point1[] = {160, 0};
	int point2[] = {0, 0};

	while(1)
	{
		tick(); // Tick the time module to calculate [delta_time];

		fill(background_color);
		point2[0] += 1 * delta_time;
		point2[1] += 1 * delta_time;
		draw_line(point1, point2, line_color);
	}

	return;
}
