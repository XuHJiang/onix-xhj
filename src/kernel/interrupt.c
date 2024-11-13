#include <onix/interrupt.h>
#include <onix/global.h>
#include <onix/debug.h>

//主要是初始化中断描述符表，将描述符表的地址记录到 idtr 寄存器中

gate_t idt[IDT_SIZE];
pointer_t idt_ptr;

extern void interrupt_handler();

void interrupt_init()
{
    for (size_t i = 0; i < IDT_SIZE; i++)
    {
        gate_t *gate = &idt[i];
        gate->offset0 = (u32)interrupt_handler & 0xffff;
        gate->offset1 = ((u32)interrupt_handler >> 16) & 0xffff;
        gate->selector = 1 << 3;
        gate->reserved = 0;
        gate->type = 0b1110;  // 中断门
        gate->segment = 0;
        gate->DPL = 0;  // 内核态
        gate->present = 1;
    }
    idt_ptr.base = (u32)idt;
    idt_ptr.limit = sizeof(idt) - 1;
    asm volatile("lidt idt_ptr\n");  // 将中断描述表的地址放到 idtr 寄存器中
}