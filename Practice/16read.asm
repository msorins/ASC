assume CS: code, DS:data
data segment public
    maxLength db 100
    readLength db ?
    readStr db 100 dup(?)
    sirSeg dw ?
    sirOff dw ?
    nr db 0
    aux db 0
data ends

code segment public
public readf

readf:
    ; INPUT
    ; AX - sir segment
    ; BX - sir offset
    push CX
    push DX

    ;Load registers
    mov sirSeg, AX
    mov sirOff, BX

    ;Read string
    mov AH, 0Ah
    mov DX, offset maxLength
    int 21h

    ;Load readStr into DS:SI
    mov AX, seg readStr
    mov DS, AX
    mov SI, offset readStr

    ;Load sirSeg:sirOff into ES:DI
    mov ES, sirSeg
    mov DI, sirOff

    ;Parse string
    mov CL, readLength
    mov CH, 0

    mov nr, 0
    repeat:
        lodsb; load DS:SI into AL, increment SI

        cmp AL, ' '
        JE notDigit
        digit:
            ;Transform the ASCII
            sub AL, '0'

            ;Backup the value of current digit
            mov aux, AL

            ;Add the new digit to the back of the number
            mov BL, 10
            mov AL, nr
            mul BL

            ;Only take the lower byte and add the current digit
            add AL, aux
            mov nr, AL

            ;Jump to the end of the repeatr
            jmp endRepeat

        notDigit:
        mov AL, nr
        stosb; store AL into ES:DI
        mov nr, 0

        endRepeat:
    loop repeat

    ;Also insert the last number
    mov AL, nr
    stosb; store AL into ES:DI

    pop DX
    pop CX
    ret
code ends
end
