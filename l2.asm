section     .text
global      _start

_start:

	mov ax,06h		; bw cga 640 x 200
	int 10h
	
	push 0B800h		; video memory address
	pop es

	; if (y % 2 == 0) goto even
	mov ax, y
	mov bx, 2
	sub dx, dx
	div bx
	sub dx, 1
	jnz even

	odd:
		mov word [y_mem], 02000h
		jmp calculate_point

	even:
		mov word [y_mem], 0

	calculate_point:
		; y_mem = ax * line + y_mem
		mov bx, line
		mul bx
		mov dx, word [y_mem]
		add ax, dx
		mov word [y_mem], ax

		; x_mem = x / byte_size
		mov ax, x
		mov bx, 8
		sub dx, dx
		div bx
		mov word [x_mem], ax

		; x_byte = 0x80 >> (x % byte_size)
		mov word [x_byte], 080h
		inc dx
		shift:
			sub dx, 1
			jz paint
			shr word [x_byte], 1
		jmp shift

	paint:
		mov di, word [y_mem]
		add di, word [x_mem]
		mov ax, word [x_byte]
		stosb
		
		mov ah, 1  ; waiting for keypress
		int 16h
	jz paint

	exit:	 
		mov ax,0003h	; back to the future
		int 10h

		mov ax,4c00h	; stop
		int 21h

section		.data

	y_mem dd 0
	x_mem dd 0
	x_byte dw 0
	x equ 213
	y equ 101
	line equ 80
