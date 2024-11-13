#ifndef ONIX_INTERRUPT_H
#define ONIX_INTERRUPT_H

#include <onix/types.h>

#define IDT_SIZE 256 // 中断描述符的个数

typedef struct  gate_t
{
    u16 offset0;
    u16 selector;
    u8 reserved;
    u8 type : 4;
    u8 segment : 1;
    u8 DPL : 2;
    u8 present : 1;
    u16 offset1;
}_packed gate_t;

typedef void *handler_t; // 中断处理函数

void interrupt_init();

#endif
