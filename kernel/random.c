#include "headers\random.h"
#include "headers\time.h"
#include "headers\math.h"

// int pseudomap[128] = { 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1, 1, 0, 0, 1, 0, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 1, 0, 0, 1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 1, 0, 0, 1, 0 };

// int time_rand()
// {
// 	if(time >= 128)
// 		restart();

// 	return pseudomap[time];
// }

unsigned int lcg(unsigned int seed)
{
	// Constants for the LCG (feel free to experiment with different values)
	const unsigned int a = 1664525;
	const unsigned int c = 10139042;
	const unsigned int m = 128000;

	static unsigned int x = 0; // Initialize the seed only once

	if (seed != 0) {
		x = seed;
	}

	x = (a * x + c) % m;
	return x;
}

int ita(int s0, int s1, int s2)
{
	unsigned int p = abs(s2 - s1 + s1 - s0);
	unsigned int frns = abs(ITA_RANDOM_RANGE1 - (p * sqrt(ITA_RANDOM_RANGE2)));

	return frns;
}