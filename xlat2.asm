.model small
.stack 100h
.data
table1 db 32 dup(00)
       db 32 
       db 32 dup(00)
       db 'FVXCHSAIYQWGOTBNZKMJPLURDE'

table2 db 32 dup(00)
       db 32 
       db 32 dup(00)
       db 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'

array1 db 41 dup(00)
       db '$'
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

mov BX, offset TABLE1
mov SI, offset array1
BB:	mov al,[SI]
	XLAT
	mov [SI],al
	inc SI
	mov dl,[SI]
	cmpam dl,'$'
	jne BB 

call PRINTNEWLINE
mov dx,offset array1
mov ah,09
int 21h
CALL PRINTNEWLINE

mov BX, offset TABLE2
mov SI, offset array1
AG:	mov al,[SI]
	XLAT
	mov [SI],al
	inc SI
	mov dl,[SI]
	cmp dl,'$'
	jne AG 

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