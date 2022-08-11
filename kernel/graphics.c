#include "header/graphics.h"

void plot(int position[], int color)
{
    unsigned int location = (320 * position[1]) + position[0];
	//int location = x * 4 + y * 320;

	//*(char *)(GRAFIC_MEMORY + location + 2) = (color >> 16) & 255;	// Adjust red;
    //*(char *)(GRAFIC_MEMORY + location + 1) = (color >> 8) & 255;		// Adjust green;
	*(char *)(GRAFIC_MEMORY + location) = color;          		// Adjust blue;
}

void fill(int color)
{
	for(int v = 0; v < SCREEN_HEIGHT; v++)
	{
		for(int h = 0; h < SCREEN_WIDTH; h++)
		{
			int position[] = {h, v};
			plot(position, color);
		}
	}
}

void draw_line(int starter_point[], int ending_point[], int color)
{
	//		For this function, allow me to adopt the convention:
	// array[0] -> [x position] and array[1] -> [y position]
	//
	// It basicaly create a line based on two given position using
	// Bresenham's line drawing algorithm (search for more info).

	int distance[] = {ending_point[0] - starter_point[0], ending_point[1] - starter_point[1]};
	int distance_absolute[] = {absolute(distance[0]), absolute(distance[1])};
	int distance_signal[] = {signal(distance[0]), signal(distance[1])};

	int x = distance_absolute[1] >> 1;
	int y = distance_absolute[0] >> 1;

	int draw_point[] = {starter_point[0], starter_point[1]};

	*(char *)(GRAFIC_MEMORY + ((starter_point[1] << 8) + (starter_point[1] << 6) + starter_point[0])) = color;

	if(distance_absolute[0] >= distance_absolute[1]) // If the line is more (or equaly) horizontal than vertical.
	{
		for(int i = 0; i < distance_absolute[0]; i++)
		{
			y += distance_absolute[1];

			if(y >= distance_absolute[0])
			{
				y -= distance_absolute[0];
				draw_point[1] += distance_signal[1];
			}

			draw_point[0] += distance_signal[0];

			plot(draw_point, color);
		}
	}
	else // If the line is more vertical than horizontal.
	{
		for(int i = 0; i < distance_absolute[1]; i++)
		{
			x += distance_absolute[0];

			if(x >= distance_absolute[1])
			{
				x -= distance_absolute[1];
				draw_point[0] += distance_signal[0];
			}

			draw_point[1] += distance_signal[1];

			plot(draw_point, color);
		}
	}
}
