#include <onix/types.h>
#include <stdio.h>


typedef struct descriptor
{
	unsigned short limit_low;
	unsigned int base_low : 24;
	unsigned char type : 4
	unsigned char segment : 1;
	unsigned char DPL : 2;
}


int main()
{
	printf("size od u8 %d\n", sizeof(u8));
	printf("size od u16 %d\n", sizeof(u16));
	printf("size od u32 %d\n", sizeof(u32));
	printf("size od u64 %d\n", sizeof(u64));

	return 0
}

