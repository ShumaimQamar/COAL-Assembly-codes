.model small
.stack 100h
.data
	array1 db 10h, 20h, 30h, 40h, 50h, 60h, 70h, 80h
	array2 db 11h, 22h, 33h, 44h, 55h, 66h, 77h, 88h
	array3 db 8 dup(00)
.code
main proc
	mov ax,@data
	mov ds,ax
	
	mov bx, offset array1
	mov si, offset array2
	mov di, offset array3
	
	call add_arrays

	mov ah,4ch
	int 21h
main endp
add_arrays proc
	mov cx,8
again: 	mov al,[bx]
	add al,[si]
	mov [di],al

	inc bx
	inc si
	inc di
	dec cx
	jnz again
	ret
add_arrays endp
end main