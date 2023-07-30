#include "headers\time.h"

unsigned int time = 0;

void tick()
{
	time++;
}

void restart()
{
	time = 0;
}