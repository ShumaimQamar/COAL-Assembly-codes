.model small
.stack 100h
.data
array1 db 12h, 23h, 43h, 11h, 43h, 23h, 63h, 35h

.code
main proc
	mov ah,01
	int 21h
	sub al,30h
	mov ax,@data
	mov ds,ax
	mov SI, offset array1
	mov cx,8
again:  mov bl,[SI]
	add bl,al
	inc SI
	dec CX
	JNZ again
	mov ah,4ch
	int 21hx
main endp
end main