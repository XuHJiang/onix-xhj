#include <onix/onix.h>
#include <onix/types.h>
#include <onix/io.h>
#include <onix/string.h>
#include <onix/console.h>
#include <onix/printk.h>
#include <onix/assert.h>

char message[] = "hello xuhj onix study.!!!!!!!\n";
char buf[1024];

void kernel_init()
{
	console_init();

	assert(3 < 5);
	//assert(3 > 5);

	panic("out of Memory");
	return;
}
