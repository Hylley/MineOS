#pragma once

// extern int pseudomap[128];
//int time_rand();

unsigned int lcg(unsigned int seed);

#define ITA_RANDOM_RANGE1 100
#define ITA_RANDOM_RANGE2 2.33333
int ita(int s0, int s1, int s2);