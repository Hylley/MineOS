void print(char text[], int length)
{
	for(int i = 0; i < length; i++)
	{
		*(char*)(0xb8000 + i * 2) = text[i];
	}

	return;
}

// Main function.

extern void start()
{
	char text[10] = "Sou lindo.";
	print(text, 10);

	return;
}
