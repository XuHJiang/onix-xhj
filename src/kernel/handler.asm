[bits 32]
; 中断处理函数入口

section .text
extern printk

global interrupt_handler
interrupt_handler:
    push message
    
    call printk
    add esp, 4

    iret

section .data
message:
    db "default interrupt", 10, 0