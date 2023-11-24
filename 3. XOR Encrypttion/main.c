#include <windows.h>

extern void XOR(char *string, int stringSize, char *key, int keySize);


int main()
{
	
	char	string[] 	= "H3110 0xPr1m0";
	char	key[]		= "k3y";
	int		stringSize	= strlen(string);


	XOR(string, stringSize, key, strlen(key));

	printf("Encrypted: {");
	for(int idx = 0; idx < stringSize; idx++) {
		printf("0x%X, ", string[idx]);
	}
	printf("}\n");

	XOR(string, stringSize, key, strlen(key));

	printf("\nDecrypted: %s\n", string);

	return (0);
}