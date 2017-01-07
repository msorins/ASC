assume CS: code, DS:data
data segment public
    tabHexa db '0123456789ABCDEF'
    pSirSeg dw ?
    pSirOff dw ?
data ends

code segment public
public printf

printf:
    ; INPUT
    ; AX - sir segment
    ; BX - sir offset
    push CX
    push DX

    ;Load registers
    mov pSirSeg, AX
    mov pSirOff, BX

    ;Put AX:BX into DS:SI
    mov DS, AX
    mov SI, BX

    ;Counter the elements
    mov CX, 0

    repeat:
        lodsb; Load into AL the byte from DS:SI, increment SI
        inc CX
        cmp AL, -1
        JE sfRepeat
    JMP repeat
    sfRepeat:

    ;Decrement the final -1 and space
    sub CX, 2

    ;Put AX:BX into DS:SI
    mov DS, pSirSeg
    mov SI, pSirOff
    add SI, CX

    ;Actually print the string in base16
    std; Set carry flag to 1
    repeat2:
        lodsb; Load into AL the byte from DS:SI, decrement SI

        ;Check to see if it is space
        cmp AL, ' '
        JE space
        digit:
            ;use XLAT
            mov BX, offset tabHexa
            xlat tabHexa

            ;print the character
            mov AH, 02h
            mov DL, AL
            int 21h

            JMP sfRepeat2

        space:
            ;print new line
            mov AH, 02h
            mov DL, 10
            int 21h

        sfRepeat2:
        cmp CX, 0
        JE sfPrint
    loop repeat2

    ;Enter again in the loop to also print the last character
    cmp CX, 0
    JE repeat2

    sfPrint:
        pop DX
        pop CX
        ret
code ends
end
