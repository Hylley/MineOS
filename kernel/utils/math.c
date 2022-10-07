int abs(int n)
{
	//		This function returns the absolute value
	// of a given number. It's pretty easy to read tho.

	if(n < 0)
	{
		return -n;
	}

	return n;
}

int sig(int n)
{
	//		A little ominous, but basically:
	// if [n] = 5:
	// 5 is greatter than 0 -> 1
	// 5 is not smaller than 0 -> 0
	// the result is 1 - 0 = 1.
	// 		This function basically return [1] if
	// [n] is positive, and [-1] if [n] is negative.
	// (Returns 0 if [n] == 0)

	return (n >= 0) - (n <= 0);
}
