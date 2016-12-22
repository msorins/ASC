; 1. A number a represented on 16 bits is given. Print on the screen a in base 16, as well as the result of all circular permutations of the digits.
assume CS:code, DS:data

data segment public
    maxNumberSize db 10
    readLength db ?
    readStr db 12 dup(?)
    nr dw 0
    zece dw 10
data ends

code segment public
extrn subf:proc ; Declare the external subf - procedure
extrn printf:proc ; Declare the external subf - procedure
start:
    mov AX, data
    mov DS, AX

    ; read from the keyboard the name of the file using interrupt 21, function 0ah
    ; the length of the readed string is in readLength
    ; the string is in readStr
    mov ah, 0ah
	mov dx, offset maxNumberSize
	int 21h

    ;PUT THE readLength value into CX
    mov CL, readLength
    mov CH, 0

    mov BP, 0
    repeat:
        mov AH, 02h

        ;Move current digit to BX
        mov BL, readStr[BP]
        sub BL, '0'
        mov BH, 0

        ;Add the current digit to nr
        mov AX, nr
        mul zece
        add AX, BX
        mov nr, AX

        inc BP
    loop repeat

    ;Call subf subprogram to transform the number to base 16
    mov AX, nr
    call subf


    mov AX, 4c00h
    int 21h
code ends
end start
