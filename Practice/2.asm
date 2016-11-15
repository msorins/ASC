; LAB 6 -> 1. Two byte strings S1 and S2 are given. Obtain the string D by concatenating the elements of S1 from
; the left hand side to the right hand side and the elements of S2 from the right hand side to the left hand side.
; Exemple:
;S1: 1, 2, 3, 4
;S2: 5, 6, 7
;D: 1, 2, 3, 4, 7, 6, 5

assume CS: code, DS: data
data segment
    S1 db 1, 2, 3, 4
    L1 EQU $-S1
    S2 db 5, 6, 7
    L2 EQU $-S2
    D db ?, ?, ?, ?, ?, ?, ?
    L3 db ?
data ends
code segment
start:
    mov AX, data
    mov DS, AX

    ;SET L3 SIZE
    mov AL, L1
    add AL, L2
    mov L3, AL



    ;MAKE A LOOP THROUGH S1
    mov CX, L1
    mov SI, 0

    jcxz Sfarsit

    RepetaS1:

    mov AL, S1[SI]
    mov D[SI], AL

    inc SI
    loop RepetaS1



    ;MAKE A LOOP THROUGH S2
    mov CX, L2
    mov SI, 0

    mov BX, L2
    sub BX, 1

    mov BP, L1


    jcxz Sfarsit

    RepetaS2:

    mov AL, S2[BX]
    mov D[BP], AL
    add BP, 1
    sub BX, 1

    inc si
    LOOP RepetaS2



    Sfarsit:      ;end of program

    mov AX, 4c00h
    int 21h
code ends
end start
