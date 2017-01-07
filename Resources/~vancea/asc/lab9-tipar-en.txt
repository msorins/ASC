assume cs:code, ds:data
data segment public
	tmp db 5 dup (?), 13, 10, '$'
data ends

code segment public
public tipar	; the subprogram 'tipar' is made visible to other modules too
tipar:
; input: ax = the number that has to be printed on the screen
; the subprogram prints the number on the screen
; it does not modify the registers, except for ax

; we save the registers so that we can use them inside the subprogram
	push bx
	push cx
	push dx
; we compute the representation on the number in base 10
	mov bx, offset tmp+5  ; bx=the address of the least written digit
	mov cx, 10	; cx = 10 (constant)
bucla:
	mov dx, 0
	div cx	; dl=current digit, ax=the rest of the number
	dec bx
	add dl, '0'
	mov byte ptr [bx], dl
	cmp ax, 0
	jne bucla

	mov dx, bx
	mov ah, 09h
	int 21h

	pop dx
	pop cx
	pop bx
	ret

code ends
end