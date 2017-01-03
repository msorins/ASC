;Read a string, compute the average of negative and positive elements
assume CS: code, DS:data

data segment
    maxSize db 100
    readLength db ?
    readStr db 100 dup(?)
    crtNr db ?
    sum dw 0
    countNr db 0
data ends

code segment
start:
    mov AX, data
    mov DS, AX

    ;put into readStr the numbers separated by ','
    mov AH, 0Ah
	  mov DX, offset maxSize
	  int 21h

    ;put readStr into DS:SI
    mov AX, seg readStr
    mov DS, AX
    mov SI, offset readStr

    ;put the number of steps for the loop
    mov CL, readLength
    mov CH, 0

    repeat:
        lodsb ; Load into AL the current byte from DS:SI
        cmp AL, ' '
        JNE digit
        ;Here is not a digit
        ;TO DO SOMETHING WITH THE DIGIT
        mov CL, crtNr
        mov CH, 0
        mov crtNr, 0

        cmp CL, 0
        JL sfRepeat
        ;HERE IT MEANS THAT THE NUMBER IS GREATER OR EQUAL TO 0
        add sum, CX
        inc countNr

        digit:
        ;;ADD a new digit to the number
        sub AL, '0' ; remove the ASCII code of the character
        mov BL, AL ;

        mov AL, crtNr
        mov CL, 10
        mul CL
        mov AH, 0
        add AL, BL

        mov crtNr, AL

        sfRepeat:


    loop repeat

    mov AX, 4c00h
    int 21h

code ends
end start
