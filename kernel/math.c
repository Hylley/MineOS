#include "headers\math.h"

unsigned int abs(int n)
{
	return n < 0 ? - n : n;
}

double fabs(double n)
{
	return n < 0 ? - n : n;
}

// Newton-Raphson love uuuuuuuuu
double sqrt(double n) {
	double guess = n;
	double prev_guess;

	do {
		prev_guess = guess;
		guess = (guess + n / guess) / 2;
	} while (fabs(guess - prev_guess) > SQUARE_ROOT_PRECISION);

	return guess;
}