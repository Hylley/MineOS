int strlen(char string[])
{
	// 		The way machines detect the end of a string, is by a NULL char at
	// the end. (NULL = a whole bit full of 0's)
	//
	// 		I spent SO MUCH TIME learning how to implement this, cuz first I
	// thought I would need to manualy asign the last NULL bit at the end of the
	// string, but actually the language itself do it. So we only need to loop
	// through the input string until find the NULL bit, count the steps and
	// them, we're done.

	int i = 0;
	while(string[i] != 0)
	{
		i++;
	}

	return i;
}

void print(char text[])
{
	int length = strlen(text);

	for(int i = 0; i < length; i++)
	{
		*(char*)(0xb8000 + i * 2) = text[i];
	}

	return;
}

// Main function.

extern void start()
{
	char text[] = "EU SOU LINDO.";
	print(text);

	return;
}
