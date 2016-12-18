assume CS:code, DS:data

data segment public
    auxSir db "0 1 2 3 4 5 6 7 8 9 A B C D E F"
    lenAuxSir EQU $-auxSir
    nr db ?
data ends

code segment public
public printf	; the subprogram 'printf' is made visible to other modules too
printf:
; input: AL = the number that has to be printed on the screen
; the subprogram prints the number on the screen
; it does not modify the registers, except for ax

; we save the registers so that we can use them inside the subprogram
	push bx
	push cx
	push dx

    ;The input is put into AL
    mov nr, AL

    printNR:
        ;mov auxSir into DS:SI
        mov SI, offset auxSir
        mov AX, seg auxSir
        mov DS, AX

        ;Initialize the for
        mov CX, lenAuxSir ; Number of steps equal to the number of characters from auxSir
        mov DL, 0 ; DL is the counter of white spaces

        for2:
            lodsb ; Load DS:SI into AL, increment SI

            cmp DL, nr

            JNE doNotPrint
            ;Here print the current base 16 digit
            mov AH, 02h
            mov DL, AL
            int 21h
            JMP final

            doNotPrint:

            cmp AL, ' '

            JNE notWhiteSpace
            ;IF the current character is a white space
            add DL, 1
            notWhiteSpace:
        loop for2

    ;Ending instructions
    final:
    pop dx
	pop cx
	pop bx

	ret

code ends
end
