;2. A string of doublewords is given. Order in decreasing order the string of the low words (least significant) from these doublewords.
;   The high words (most significant) remain unchanged.
;Ex: being given: sir DD 12345678h 1256ABCDh, 12AB4344h
;the result will be 1234ABCDh, 12565678h, 12AB4344h.

assume DS: data, CS:code
data segment
    sir dd 12345678h, 1256ABCDh, 12AB4344h
    len EQU ($-sir) / 4
    a dw ?
    b dw ?
    ok db ?
data ends
code segment
start:
    mov AX, data
    mov DS, AX

    ;Initialize repeat number of steps
    mov CX, len

    repeat:
        mov BX, CX  ; SAVE CX VALUE

        ;Initialize repeat2 numbers of steps
        mov CX, len
        sub CX, 1

        ;Move the sir into DS:SI
        mov SI, OFFSET sir
        mov AX, SEG sir
        mov DS, AX

        mov ok, 1
        repeat2:
            lodsw ; the low word from addres DS:SI is loaded into AX
            mov a, AX
            lodsw ; the high word from addres DS:SI is loaded into AX
            lodsw ; the low word from addres DS:SI is loaded into AX
            mov b, AX

            SUB SI, 2 ; to normalize the next iteration through repeat2

            mov AX, a
            cmp AX, b
            JAE noSwap
            ;Do The Swap
            add ok, 1

            mov AX, b
            mov word PTR [SI-4], AX

            mov AX, a
            mov WORD PTR [SI], AX
            noSwap:
        loop repeat2


        mov CX, BX ; RESTORE CX VALUE

        sub ok, 1
    loopne repeat



    mov AX, 4c00h
    int 21h
code ends
end start
