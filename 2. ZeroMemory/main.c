#include <windows.h>

extern void ZeroMemoryEx(char *dest, int size);

int main()
{
	
	char string[] = "0xPrimo";

	ZeroMemoryEx(string, strlen(string));

	return (0);
}