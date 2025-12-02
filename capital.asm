.model small
.stack 100h
.data
msg1 db "Capital$"
msg2 db "Small$"
.code
main proc

	mov ax,@data
	mov ds,ax
	mov ah,01
	int 21h
	cmp al,5Bh
	JLE cap
	mov dx, offset msg2
	jmp exit
cap:	mov dx, offset msg1
exit:	mov ah,09
	int 21h
	mov ah,4ch
	int 21h
main endp
end main