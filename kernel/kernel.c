#include "headers\graphic.h"
#include "headers\random.h"
#include "headers\time.h"
#include "headers\math.h"

extern void kernel()
{
	// Generate pseudo-random white dots.
	for(unsigned int y = 0; y < GRAPHIC_HEIGHT; y++)
	{
		for(unsigned int x = 0; x < GRAPHIC_WIDTH; x++)
		{
			tick();
			plot(position(x, y), 15 * (lcg(x * y * time) < 32000 / 10));
		}
	}

	

	return;
}