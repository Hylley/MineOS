#include <string.h>

void print(char text[])
{
	int lenght = strlen(text);

	for(int i = 0; i < lenght; i++)
	{
		*(char*)(0xb8000 + i * 2) = text[i];
	}

	return;
}
