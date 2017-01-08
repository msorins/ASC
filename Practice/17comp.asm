assume CS: code, DS:data
data segment public
    sSeg dw ?
    sStringOff dw ?
    sSubstringOff dw ?
    msg2 db 'Number of aparitions of the word in file is: $'
    i db ?
    auxi db ?
    j db ?
    counter db 0
data ends

code segment public
public compute
compute:
    ; INPUT
    ; AX - sSegment
    ; BX - sStringOffset
    ; CX - sSubstringOffset
    push DX

    ; Move the input registers into variables
    mov sSeg,          AX
    mov sStringOff,    BX
    mov sSubstringOff, CX

    ; Put the string in DS:SI
    mov DS, sSeg
    mov SI, sStringOff

    mov i, 0
    mov j, 0
    repeatI:
        mov BL, i
        mov BH, 0

        ;Backup value of i
        mov auxi, BL

        ;i element

        add BX, sStringOff
        mov AL, byte ptr [BX]
        mov AH, 0

        ;Exit condition
        cmp AX, 0
        JE endCompute

        ;Reset the value of j
        mov DX, 0
        mov j, DL

        repeatJ:
            mov BL, j
            mov BH, 0

            ;j element
            add BX, sSubstringOff
            mov CL, byte ptr [BX]
            mov CH, 0

            ;Check if substring is fully matched (valid condition)
            cmp CX, 0
            JE validSubstring

            ;Exit condition ( i != j => AX != CX )
            cmp AX, CX
            JNE exitRepeatJ

            ;Ending instrunctions
            inc j

            ;Next value of i
            inc i
            mov BL, i
            mov BH, 0

            add BX, sStringOff
            mov AL, byte ptr [BX]
            mov AH, 0


        JMP repeatJ
        exitRepeatJ:

        ;Restore value of i
        mov BL, auxi
        mov i, BL

        inc i
    JMP repeatI

    ;Increment counter if the substring is found
    validSubstring:
        inc counter
        JMP exitRepeatJ


    endCompute:
        ;Print msg2 to the console
        mov AH, 09h
        mov DX, offset msg2
        int 21h

        ;Print the digit to the console
        mov AH, 02h
        mov DL, counter
        add DL, '0'
        int 21h

        pop DX
        ret
code ends
end
