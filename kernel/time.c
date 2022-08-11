#include "header/time.h"

void tick()
{
	previus_time = time;
	time ++;
	delta_time = time - previus_time;
}
