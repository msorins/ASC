assume CS: code, DS: data

data segment public
    sirOff1 dw ?
    sirOff2 dw ?
    sirOff3 dw ?
    sirSeg dw ?
data ends

code segment public
public concatenate

concatenate:
    ;INPUT
    ; AX - OFFSET SIR1
    ; BX - OFFSET SIR2
    ; CX - OFFSET SIR3
    ; DX - SEG SIR1&2&3

    mov sirOff1, AX
    mov sirOff2, BX
    mov sirOff3, CX
    mov sirSeg,  DX


    ;mov sir1 into DS:SI
    mov DS, sirSeg
    mov SI, sirOff1

    ;mov sir3 into ES:DI
    mov ES, sirSeg
    mov DI, sirOff3

    ;concatenate sir1 to sir3
    repeat1:
        lodsb; load into AL the byte from DS:SI (increment SI)
        cmp AL, 0
        JE endRepeat1
        dec SI

        movsb; move DS:SI into ES:DI (increment SI and DI)
    jmp repeat1
    endRepeat1:

    ;mov sir2 into DS:SI
    mov DS, sirSeg
    mov SI, sirOff2

    ;concatenate sir2 to sir3
    repeat2:
        lodsb; load into AL the byte from DS:SI (increment SI)
        cmp AL, 0
        JE endRepeat2

        dec SI
        movsb; move DS:SI into ES:DI (increment SI and DI)
    jmp repeat2
    endRepeat2:



    ret
code ends
end
