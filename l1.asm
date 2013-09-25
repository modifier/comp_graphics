section     .text
global      _start

_start:

	mov ax,06h		; bw cga
	int 10h
	
	push 0B800h		; video memory address
	pop es	

	new_loop:	
		mov di, 020A0h
		mov al, 09h		; 1001
		stosb 
		
		mov ah, 1  ; waiting for keypress
		int 16h
	jz new_loop
	 
	mov ax,0003h
	int 10h

	mov ax,4c00h
	int 21h	        
