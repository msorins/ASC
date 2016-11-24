;11. A string of doublewords is given. Compute the string formed by the high bytes of the low words from the elements
;   of the doubleword string and these bytes should be multiple of 10.
;Ex: Being given the string: s dd 12345678h, 1A2B3C4Dh, FE98DC76h
;The result is the string: d db 3Ch, DCh.

assume DS: data, CS:code
data segment
    sir dd 12345678h, 1A2B3C4Dh, 0FE98DC76h, 0AAAA50AAh
    len EQU ($-sir) / 4
    rasp db 0
data ends
code segment
start:
    mov AX, data
    mov DS, AX

    ;initialize number of steps
    mov CX, len

    ;mov sir into DS:SI
    mov SI, offset sir
    mov AX, seg sir
    mov DS, AX

    ;usef for the div
    mov BL, 10
    repeta:
        lodsw; load into AX the low word (from the addres DS:SI), increment SI

        shr AX, 8; shift highest 8 bits from the word to the right
        div BL

        cmp AH, 0 ;Check to se if AX % 10 == 0
        jne sfRepeta
        ;If the number is multiple of 10
        add rasp, 1

        sfRepeta:
            lodsw; load into AX the high word (from the address DS:SI), increment S;

    loop repeta

    mov AX, 4c00h
    int 21h
code ends
end start
