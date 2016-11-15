;9. A byte string S is given. Obtain the string D1 which contains all the positive numbers of S and the string D2 which contains all the negative numbers of S.
;Exemple:
;S: 1, 3, -2, -5, 3, -8, 5, 0
;D1: 1, 3, 3, 5, 0
;D2: -2, -5, -8

assume DS: data, CS: code
data segment
    S db 1, 3, -2, -5, 3, -8, 5, 0
    LS EQU $-S
    D1 db ?, ?, ?, ?, ?, ?, ?, ?
    D2 db ?, ?, ?, ?, ?, ?, ?, ?
data ends
code segment
start:
    mov AX, data
    mov DS, AX

        ;Make a loop through S
        mov CX, LS
        mov SI, 0

        ;RESET BX and BP counters
        mov BX, 0
        mov BP, 0

        ;Jump to the end if CX is not 0
        jcxz Sfarsit


        Repeta:
        mov AL, S[SI]

        AND AL, 1000000b
        SHR AL, 6
        CMP AL, 1

        JE Negativ
        ;Here deal with the positive numbers
        mov DL, S[SI]
        mov D1[BX], DL
        add BL, 1

        ;INCREMENT
        inc SI ; SI := SI + 1
        loop Repeta

        jmp Sfarsit

        Negativ:
        ;Here deal with the negative numbers
        mov Dl, S[SI]
        mov D2[BP], DL
        add BP, 1

        ;INCREMENT
        inc SI ; SI := SI + 1
        loop Repeta




        Sfarsit:    ;End of program

    mov AX, 4c00h
    int 21h
code ends
end start
