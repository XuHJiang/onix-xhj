[bits 32]

section .text

global inb
inb:
    push ebp
    mov ebp, esp

    xor eax, eax
    mov edx, [ebp + 8] ;port
    in al, dx  ; 将端口号 dx 的 8 bit 输入到 ax

    jmp $+2
    jmp $+2
    jmp $+2

    leave
    ret

global outb
outb:
    push ebp
    mov ebp, esp

    mov edx, [ebp + 8] ;port
    mov eax, [ebp + 12] ;value
    out dx, al 

    jmp $+2
    jmp $+2
    jmp $+2

    leave
    ret

global inw
inw:
    push ebp
    mov ebp, esp

    xor eax, eax
    mov edx, [ebp + 8] ;port
    in ax, dx  ; 将端口号 dx 的 8 bit 输入到 ax

    jmp $+2
    jmp $+2
    jmp $+2

    leave
    ret

global outw
outw:
    push ebp
    mov ebp, esp

    mov edx, [ebp + 8] ;port
    mov eax, [ebp + 12] ;value
    out dx, ax

    jmp $+2
    jmp $+2
    jmp $+2

    leave
    ret