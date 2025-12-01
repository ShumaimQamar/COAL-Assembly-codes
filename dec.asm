.model small
.stack 100h
.data

.code
main proc
	mov ax,@data
	mov ds,ax
	
	call binary_input
	call decimal_output

	mov ah,4ch
	int 21h
main endp

binary_input proc
	mov bx,0
	mov cx,16
again:	mov ah,01
	int 21h
	sub al,30h
	shl bx,1
	or bl,al
	dec cx
	jnz again
	ret
binary_input endp

hex_input proc
	mov bx,0000h	
	mov cl,4
	mov ch,4
again1:	mov ah,01
	int 21h
	cmp al,'9'
	jbe is_digit
	sub al,37h
	jmp exit
is_digit:sub al,30h
exit:	shl bx,cl
	or bl,al
	dec ch
	jnz again1
	ret 
hex_input endp

hex_output proc
	push dx
	mov bx,dx
	mov dx,0
	mov cl,4
	mov ch,4
againa:	ROL bx,cl
	mov dl,bl
	and dl,0Fh
	cmp dl,09
	jle aa
	add dl,37h
	mov al,02
	int 21h
	jmp exit2
aa:	add dl,30h
	mov ah,02
	int 21h
exit2:	dec ch
	jnz againa
	pop dx
	ret
hex_output endp

binary_output proc
	push dx
	mov bx,dx
	mov dx,0
	mov cx,16
againb:	rol bx,1
	jc one
	mov dl, '0'
	mov ah,02
	int 21h
	jmp exit3
one:	mov dl,'1'
	mov ah,02
	int 21h
exit3:	dec cx
	jnz againb
	pop dx
	ret
binary_output endp

decimal_output proc
	push bx
	mov ax,bx
	mov dx,0
	mov bx,10
	mov cx,0
again2:	div bx	
	push dx
	inc cx
	mov dx,0
	cmp ax,0
	jne again2

again3:	pop dx
	add dx,30h
	mov ah,02
	int 21h
	dec cx
	jnz again3
	pop bx
	ret
decimal_output endp

end main