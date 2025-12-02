.model small
.stack 100h
.data
	bin1 db "Enter a binary number up to 8 digits: $"
	tryAgain db "Illegal command to store binary, try Again: $"
	output_bin db  "The binary sum is: $"
	output_hex db "The hex sum is: $"	
.code
main proc
	mov ax,@data
	mov ds,ax
input1:	mov dx,offset bin1
	mov ah,09
	int 21h
	
	mov bl,0
	mov ch,0
	
in1:	mov ah,01
	int 21h

	cmp al,0Dh
	je check1
	
	cmp ch,8
	jge in1
	
	cmp al, '0'
    	je valid1
    	cmp al, '1'
    	je valid1
   	jmp illegal1

valid1: sub al,30h
	SHL bl,1
	add bl,al
	inc ch
	jmp in1

check1: cmp ch,8
	jne illegal1
	jmp input2

illegal1:mov dx, offset tryAgain
	mov ah,09
	int 21h
	jmp input1

input2:	mov dx,offset bin1
	mov ah,09
	int 21h

	mov bh, 0
	mov ch,0
in2:	mov ah,01
	int 21h

	cmp al,0Dh
	JE check2
	
	cmp ch,8
	jge in2

	cmp al, '0'
    	je valid2
   	cmp al, '1'
   	je valid2
   	jmp illegal2
	
valid2:	sub al, 30h
   	 shl bh, 1
   	 add bh, al
   	 inc ch
   	 jmp in2

check2:	cmp ch,8
	jne illegal2
	jmp cal

illegal2:mov dx, offset tryAgain
   	 mov ah, 09h
   	 int 21h
   	 jmp input2	

cal:	mov al, bl       
    	add al, bh       
   	mov bl, al       
   	mov bh, 0	
	mov dx, offset output_bin
    	mov ah, 09h
    	int 21h
	
	jnc bin8
	mov dl,'1'
	mov ah,02
	int 21h
	
bin8:	mov cx,8
again:	SHL bl,1
	JC ONE
	mov dl,'0'
	mov ah,02
	int 21h
	jmp exit1

ONE:	mov dl,'1'
	mov ah,02
	int 21h

exit1:	dec cx
	JNZ again

	mov dx, offset output_hex
	mov ah,09
	int 21h
	
	mov bl,al
	mov ch,2
again2:	mov cl,4
	ROL bl,cl
	mov dl,bl
	AND dl,0Fh

	cmp dl,09
	JLE AA
	add dl,37h
	mov ah,02
	int 21h
	jmp exit2
AA:	add dl,30h
	mov ah,02
	int 21h
exit2:	dec ch
	jnz again2

	mov ah,4ch
	int 21h
	
main endp	
end main