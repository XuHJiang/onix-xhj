#include <onix/onix.h>
#include <onix/types.h>
#include <onix/io.h>
#include <onix/string.h>

// #define CRT_ADDR_REG 0X3d4
// #define CRT_DATA_REG 0X3d5

// #define CRT_CURSOR_H 0Xe
// #define CRT_CURSOR_L 0Xf

char message[] = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaa!!!!!!!";
char buf[1024];

void kernel_init()
{
	// outb(CRT_ADDR_REG, CRT_CURSOR_H);
	// u16 pos = inb(CRT_DATA_REG) << 8;
	// outb(CRT_ADDR_REG, CRT_CURSOR_L);
	// pos |= inb(CRT_ADDR_REG);

	int res;
	res = strcmp(buf, message);

	return;
}
