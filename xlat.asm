.model small
.stack 100h
.data
table1 db 32 dup(00)
       db 32 
       db 32 dup(00)
       db 'DEFGHIJKLMNOPQRSTUVWXYZABC'

array1 db 'HELLO$'
newline DB 13,10,'$'
.code
main proc
	mov ax,@data
	mov ds,ax
	mov SI, offset array1
	
again:	mov ah,01
	int 21h	
	mov [SI],al
	INC SI
	mov bl,[SI]
	cmp bl,'$'
	jne again

CALL PRINTNEWLINE
mov dx,offset array1
mov ah,09
int 21h
CALL PRINTNEWLINE

mov BX, offset TABLE1
mov SI, offset array1
BB:	mov al,[SI]
	XLAT
	mov [SI],al
	inc SI
	mov dl,[SI]
	cmp dl,'$'
	jne BB 

mov dx,offset array1
mov ah,09
int 21h

	mov ah,04ch
	int 21h

main endp

PRINTNEWLINE proc

	MOV DX,OFFSET newline
	MOV AH,09
	INT 21h
	
	RET
PRINTNEWLINE endp
end main