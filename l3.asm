section     .text
global      _start

_start:
	mov ax,06h		; bw cga 640 x 200
	int 10h
	
	push 0B800h		; video memory address
	pop es

	keypress:
		mov ah, 1  ; waiting for keypress
		int 16h
	jz redraw
 
	mov ax,0003h	; back to the future
	int 10h

	mov ax,4c00h	; stop
	int 21h

	redraw:
		mov word [y], y_start
		mov word [x], x_start
		mov word [iterator], length

	next_point:
		dec word [iterator]
		jz keypress
		inc word [x]
		call draw_point
		jmp next_point

	draw_point:
		pusha

		; if (y % 2 == 0) goto even
		mov ax, word [y]
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
			mov ax, word [x]
			mov bx, 8
			sub dx, dx
			div bx
			mov word [x_mem], ax

			; x_byte = 0x80 >> (x % byte_size)
			mov byte [x_byte], 080h
			inc dx
			shift:
				sub dx, 1
				jz paint
				shr byte [x_byte], 1
			jmp shift

			paint:
				mov si, word [y_mem]
				add si, word [x_mem]

				; save ds to avoid any side effects and properly load existing byte
				push ds
				push es
				pop ds
				lodsb
				pop ds

				mov di, word [y_mem]
				add di, word [x_mem]
				or al, byte [x_byte]
				stosb
		popa
	ret

section	.data

	y_mem dd 0
	x_mem dd 0
	x_byte db 0
	
	x dw 0
	y dw 0
	iterator dw 0
	
	x_start equ 213
	y_start equ 101
	length equ 100
	
	line equ 80
