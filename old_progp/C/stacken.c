#include <stdio.h>
#include <stdlib.h>
	
int main(int argc, char *argv[])
{
	long long longlong1, longlong2;
	unsigned int uint1, uint2;
	char charv[5];
	float decnum;
	
	printf("type: long long \t address: %lx \t size: %d\n", (long)&longlong1, 	(int)sizeof(longlong1));
	printf("type: long long	\t address: %lx \t size: %d\n", (long)&longlong2,	(int)sizeof(longlong2));
	printf("type: uint	\t address: %lx \t size: %d\n", (long)&uint1,		(int)sizeof(uint1));
	printf("type: uint	\t address: %lx \t size: %d\n", (long)&uint2,		(int)sizeof(uint2));
	printf("type: char[5]	\t address: %lx \t size: %d\n", (long)&charv,		(int)sizeof(charv));
	printf("type: float	\t address: %lx \t size: %d\n", (long)&decnum,	 	(int)sizeof(decnum));
	
	return 0;
}
