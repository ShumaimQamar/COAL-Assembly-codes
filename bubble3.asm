.model small
.stack 100H
.data
newline DB 13,10,'$'

array1 db 43h,76h,23h,54h,98h,23h,65h,43h,98h,65h,34h,22h,55h,33h,34h,2h
.code
main proc
mov ax,@data
mov ds,ax
mov si,offset array1
mov di,offset array1
inc di
mov cl,15
againcall:mov ch,15
mov si,offset array1
mov di,offset array1
inc di
 call bubble_sort
          dec cl
         jnz againcall

mov cx,16
mov si,offset array1
mov di,offset array1
inc di
outputcall:mov bx,[si]
       call output_hex
       call PRINTNEWLINE
       inc si
       dec cx
       jnz outputcall
mov ah,4ch
int 21h
main endp


bubble_sort proc

again:mov ah,[si]
cmp ah,[di]
JA swap
jmp exit
swap: XCHG ah,[di]
mov [si],ah
exit:inc di
inc si
dec ch
jnz again
ret
bubble_sort endp
PRINTNEWLINE proc

	MOV DX,OFFSET newline
	MOV AH,09
	INT 21h
	
	RET
PRINTNEWLINE endp

output_hex proc
        push cx
	MOV CL,4
	MOV CH,4
	mov bh,00h
	again2:
		ROL BX,CL
		MOV DL,BL
		AND DL,0FH 
		CMP DL,9
		JLE digit
		ADD DL,37H
		JMP nextdigit		
		digit:
		   ADD DL,30H
		nextdigit:
			cmp ch,2
			JA no_output
			MOV AH,02
			INT 21H
	no_output:DEC CH
			JNZ again2
               pop cx
	RET
output_hex endp
end main