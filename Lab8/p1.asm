;1. A string of bytes is given in the data segment. Print on the standard output (screen) the elements of this string in base 2.
assume DS: data, CS:code
data segment
    sir db 3, 15, 201, 130, 17
    len EQU $-sir
    aux dw ?
    aux2 db ?
data ends
code segment
start:
    mov AX, data
    mov DS, AX

    ;mov into DS:SI sir
    mov SI, offset sir
    mov AX, seg sir
    mov DS, AX

    ;Number of repeats
    mov CX,  len
    repeta1:
        lodsb ; mov into AL the current byte from DS:SI, increment SI

        mov aux, CX
        mov CX, 8
        repeta2:
            rcl AL, 1 ; Rotate on left with carry
            mov aux2, AL ; SAVE DATA OF AL INTO aux2

            JNC zero
            ;Here the most unsignificant byte is 1
            mov AH, 02h
            mov DL, 1
            add DL, '0'
            int 21h
            jmp sfRepeta2

            zero:
            ;Here the most unsignificant byte is 0
            mov AH, 02h
            mov DL, 0
            add DL, '0'
            int 21h

            sfRepeta2:

            mov AL, aux2 ; REstore data of AL from aux2
        loop repeta2

        ;Print new line
        mov DL, 10
        mov AH, 02h
        int 21h


        mov CX, aux


    loop repeta1



    mov AX, 4c00h
    int 21h
code ends
end start
