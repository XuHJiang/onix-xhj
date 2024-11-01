[org 0x7c00]

;设置屏幕模式为文本模式
mov ax, 3
int 0x10

;初始化段寄存器，段寄存器只能使用ax,bx这类的通用寄存器复制，没有给段寄存器直接赋值的电路
mov ax, 0
mov ds, ax
mov es, ax
mov ss, ax
mov sp, 0x7c00  ; 设置栈指针，栈向地址低的地方扩展

mov si, booting  ; booting经编译后是一个地址，将这个地址赋值给源地址基址寄存器
call print

mov edi, 0x1000  ;将磁盘数据读取到0x1000这个位置
mov ecx, 2
mov bl, 4

call read_disk

cmp word[0x1000], 0x55aa
jnz error

jmp 0:0x1000 ;将loader读取到0x1000这个位置，起始8个字节以占用

jmp $

read_disk:
	mov dx, 0x1f2
	mov al, bl
	out dx, al

	inc dx
	mov al, cl
	out dx, al

	inc dx
	shr ecx, 8
	mov al, cl
	out dx, al

	inc dx
	shr ecx, 8
	mov al, cl
	out dx, al

	inc dx
	shr ecx, 8
	and cl, 0b1111

	mov al, 0b1110_0000
	or al, cl
	out dx, al

	inc  dx
	mov al, 0x20
	out dx, al

	xor ecx, ecx  ; 异或，ecx清零
	mov cl, bl    ; 读取扇区的数量

	.read:
		push cx   ; [call .waits] 和 [call .reads]是读取一个扇区
		call .waits
		call .reads
		pop cx    ; 这儿弹出cx使得之后的loop将其值减一
		loop .read

	ret	
	
	.waits:
		mov dx, 0x1f7
		.check:
			in al, dx
			jmp $+2
			jmp $+2
			jmp $+2
			and al, 0b1000_1000
			cmp al, 0b0000_1000
			jnz .check
	ret

	.reads:
		mov dx, 0x1f0
		mov cx, 256
		.readw:
			in ax, dx
			jmp $+2
			jmp $+2
			jmp $+2
			mov [edi], ax
			add edi, 2
			loop .readw
	ret

print:
	mov ah, 0x0e
.next:
	mov al, [si]
	cmp al, 0
	jz .done
	int 0x10
	inc si
	jmp .next
.done:
	ret

booting:
	db "Booting Onix...", 10, 13, 0;

error:
	mov si, .msg
	call print
	hlt ; 让cpu停止
	jmp $
	.msg db "Booting Error!!", 10, 13, 0


times 510 - ($ - $$) db 0
db 0x55, 0xaa
