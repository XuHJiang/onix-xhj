extern void console_init();
extern void gdt_init();
extern void interrupt_init();
extern void clock_init();
extern void hang();

char message[] = "hello xuhj onix study.!!!!!!!\n";
char buf[1024];

void kernel_init()
{
	console_init();
	gdt_init();

	interrupt_init();
	// task_init();
	
    clock_init();
    asm volatile("sti");
    hang();
}
