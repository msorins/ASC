assume CS:code, DS:data

data segment public
    auxSir db "0 1 2 3 4 5 6 7 8 9 A B C D E F"
    lenAuxSir EQU $-auxSir
    doi db 2
    putereDoi db ?
    nr db ?
    mainNr db ?
    auxCX dw ?
data ends

code segment public
public subf	; the subprogram 'subf' is made visible to other modules too
subf:
; input: AL = the number that has to be printed on the screen
; the subprogram prints the number on the screen
; it does not modify the registers, except for ax

; we save the registers so that we can use them inside the subprogram
	push bx
	push cx
	push dx
; we compute the representation on the number in base 16

    ;Go through all the 4 bites groups
    mov mainNr, AL
    mov CX, 2
    for0:
        mov nr, 0
        mov putereDoi, 8
        mov auxCX, CX ; Save value of CX INTO auxCX
        mov CX, 4

        ;Take groups of 4 bites
        for:
            rcl mainNr, 1 ; Rotate with carry to left
            JNC sfFor
            ;If the current bit is 1 transform the number to base 10
            mov DL, nr
            add DL, putereDoi
            mov nr, DL

            sfFor:
            ;Put in AX crt putereDoi
            mov AL, putereDoi
            mov AH, 0

            ;Divide it with two for the following iteration
            div doi ; AL := AX / 2
            mov putereDoi, AL

        loop for

        JMP printNR

        goBackInFor0:
        mov CX, auxCX; Restore value of auxCX into CX
    loop for0
    jmp Final

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
            JMP goBackInFor0

            doNotPrint:

            cmp AL, ' '

            JNE notWhiteSpace
            ;IF the current character is a white space
            add DL, 1
            notWhiteSpace:
        loop for2

        JMP goBackInFor0

    ;Ending instructions
    final:
    pop dx
	pop cx
	pop bx

	ret

code ends
end
