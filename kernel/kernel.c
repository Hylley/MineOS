#include "headers\graphic.h"
#include "headers\random.h"
#include "headers\time.h"
#include "headers\math.h"
#include "headers\mem.h"

extern void kernel()
{
	/*
		Each new generation gets evaluated based on the last
		generation. Wich means we need to have two instances of the
		field.	
	*/
	char* prev_gen = alloc(GRAPHIC_HEIGHT * GRAPHIC_WIDTH * sizeof(char));
	unsigned int t = 0;
	for(unsigned int y = 0; y < GRAPHIC_HEIGHT; y++)
	{
		for(unsigned int x = 0; x < GRAPHIC_WIDTH; x++)
		{
			int color = 15 * (lcg(x * y * t) < 32000 / 5); // Generate pseudo-random white dot.
			prev_gen[t] = color;
			plot(position(x, y), color);
			t++;
		}
	}

	// prev_gen[63998] = 15;

	// plot(position(0, 0), prev_gen[63998]);

	// char end = 0;
	// do
	// {
	// 	tick();

	// 	if(!time % 10)
	// 		continue;

	// 	for(unsigned int y = 0; y < GRAPHIC_HEIGHT; y++)
	// 	{
	// 		for(unsigned int x = 0; x < GRAPHIC_WIDTH; x++)
	// 		{
	// 			int alive = grab(position(x, y))/15;
				
	// 			int top = safe_grab(x, y - 1); // Divide by 15 to make it 1 or 0.
	// 			int bot = safe_grab(x, y + 1);
	// 			int lef = safe_grab(x - 1, y);
	// 			int rig = safe_grab(x + 1, y);

	// 			int t_l = safe_grab(x - 1, y - 1);
	// 			int t_r = safe_grab(x + 1, y - 1);
	// 			int b_l = safe_grab(x - 1, y + 1);
	// 			int b_r = safe_grab(x + 1, y + 1);

	// 			int neighbors = (top + bot + lef + rig + t_l + t_r + b_l + b_r) / 15;

	// 			if(!alive && neighbors == 3)
	// 			{
	// 				plot(position(x, y), 15);
	// 				continue;
	// 			}

	// 			if(alive && (neighbors < 2 || neighbors > 3))
	// 			{
	// 				plot(position(x, y), 0);
	// 				continue;
	// 			}
	// 		}
	// 	}

	// 	break;
	// } while (!end);

	return;
}