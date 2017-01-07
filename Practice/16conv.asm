assume CS: code, DS:data
data segment public
    sirSeg dw ?
    sir1Off dw ?
    sir2Off dw ?
    nr db ?
    aux db ?
data ends

code segment public
public convert

convert:
    ; INPUT
    ; AX - sir1&sir2 SEGMENT
    ; BX - sir1 OFFSET
    ; CX - sir2 OFFSET
    push DX

    ;Load input into variables
    mov sirSeg, AX
    mov sir1Off, BX
    mov sir2Off, CX

    ;load sir1 into DS:SI
    mov DS, sirSeg
    mov SI, sir1Off

    ;load sir2 into ES:DI
    mov ES, sirSeg
    mov DI, sir2Off

    ;Loop through all items in DS:SI
    repeat:
        lodsb; Load DS:SI into AL, increment SI
        mov nr, AL

        ;Exit confition
        cmp AL, 0
        JE sfConvert

        JMP convertNR
        backConvertNr:
    JMP repeat


    convertNR:
        repeat2:
            ;Move nr to AX
            mov AL, nr
            mov AH, 0

            ;Divide by 16
            mov BL, 16
            div BL ; AL := AX / 16 ,  AH := AX : 16

            ;for the next iteration
            mov nr, AL

            ;Put current digit in the new string
            mov AL, AH
            stosb

            ;Exit condition
            cmp nr, 0
            JE endRepeat2
        JMP repeat2
        endRepeat2:

      mov AL, ' '
      stosb

    jmp backConvertNr

    sfConvert:
    ;Mark the end of the string with -1
    mov AL, -1
    stosb

    pop DX
    ret
code ends
end
