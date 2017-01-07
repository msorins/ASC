assume CS: code, DS:data
data segment public
    maxLength db 100
    readLength db ?
    readStr db 100 dup(?)
    crtNr db 0
    aux db 0
    sirSeg dw ?
    sirOff dw ?
data ends


code segment public
public readf
readf:
    ; INPUT
    ; AX - seg string
    ; BX - offset string
    push CX
    push DX

    ;Backup parameters into variables
    mov sirSeg, AX
    mov sirOff, BX

    ;Read the string
    mov AH, 0Ah
    mov DX, offset maxLength
    int 21h

    ;Load readStr into DS:SI
    mov AX, seg readStr
    mov DS, AX
    mov SI, offset readStr

    mov CL, readLength
    mov CH, 0

    ;Load input string into ES:DI
    mov ES, sirSeg
    mov DI, sirOff


    repeat:
        lodsb ; Load DS:SI into AL, increment SI

        cmp AL, ' '

        JE notDigit
        digit:
            ;Backup the value of AL into aux
            sub AL, '0'
            mov aux, AL

            ; crtNr = crtNr * 10
            mov BL, 10
            mov AL, crtNr
            mul BL ; AX := AL * BL

            ; Take only the low byte from AX
            add AL, aux

            ; Put the result into crtNr
            mov crtNr, AL

            jmp endLoop

        notDigit:
            ;Load the formed number into ES:DI
            mov AL, crtNr
            stosb; Put AL into ES:DI, increment DI
            ;Reset the number
            mov crtNr, 0

        endLoop:
    loop repeat

    ;Also put the last number
    mov Al, crtNr
    stosb

    pop DX
    pop CX
    ret
code ends
end
