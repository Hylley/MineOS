#include "headers/debug.h"

void print(char *str)
{
    int i = 0;

    while (str[i] != 0)
    {
        *(char *)(0xb8000 + i * 2) = str[i];
        i++;
    }
}