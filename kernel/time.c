#include "header/time.h"

void tick()
{
	previus_time = current_time;
	current_time ++;
	delta_time = current_time - previus_time;
}
