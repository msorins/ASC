;4. Being given two strings of bytes, compute all positions where the second string appears as a substring in the first string.

assume DS: data, CS:code
data segment
    a db 'ab bababababab'
    la EQU $-a
    b db 'ab'
    lb EQU $-b
    matchedSubstrings db 0
data ends
code segment
start:
    mov AX, data
    mov DS, AX

    ;set number of steps equal to string a length
    mov CX, la

    ;move string a to DS:SI
    mov SI, offset a
    mov AX, seg a
    mov DS, AX


    repeat:
        lodsb ; load into AL content of DS:SI, increment SI

        cmp AL, a[0]
        JNE sfLoop ;If current character does not match first character in substring, go to the next one

        ;move substring into ES:DI
        mov DI, offset b
        mov AX, seg b
        mov ES, AX

        ;SAVE CX INTO BX and SI into DX
        mov BX, CX
        mov DX, SI

        mov CX, lb ; Set number of steps, equal with substring length
        dec SI ; Decrement current SI position (because lodsb incremented id before)
        repeat2:
            cmpsb ; compare DS:SI with ES:DI and increment SI & DI

            JNE restoreStuff ; if they do not match
        loop repeat2

        add matchedSubstrings, 1 ; If execution gets in this point, then the substring matched the string

        ;RESTORE BX into CX
        restoreStuff:
            mov CX, BX
            mov SI, DX

        sfLoop:
    loop repeat ; decrement

    mov AX, 4c00h
    int 21h
code ends
end start
