;1. Being given two alphabetical ordered strings of characters, s1 and s2, build using merge sort the ordered string of bytes that contain all characters from s1 and s2.
assume DS: data, CS:code
data segment
    a db 'a', 'c', 'f'
    la EQU $-a
    nra db la
    b db 'b', 'c', 'm', 'r', 'v', 'w'
    lb EQU $-b
    nrb db lb
    c db ?, ?, ?, ?, ?, ?, ?, ?, ?, ?
    lc db 0
data ends
code segment
start:
    mov AX, data
    mov DS, AX

    ; Number of steps
    mov CX, la
    add CX, lb ;

    mov BP, 0 ; Number of elements in C

    ;Put a into DS:SI
    mov SI, OFFSET a
    mov AX, SEG A
    mov DS, AX

    ;Put b into ES:DI
    mov DI, OFFSET B
    mov AX, SEG B
    mov ES, AX

    cld ; Clear direction flag, loop from left to right
    repeta:
        cmpsb ; compare byte from DS:SI with byte from ES:DI

        JNS aGRthanb
        ;A is smaller than B
        dec SI
        dec DI

        mov AL, [SI]
        mov c[BP], AL
        inc SI
        inc BP
        dec nra
        jmp endLoop

        aGRthanb:
        ;A is greater than B
        dec SI
        dec DI

        mov AL, [DI]
        mov c[BP], AL
        inc DI
        inc BP
        dec nrb

        endLoop:
    loopne repeta


    ;LOOP THROUGH THE REST OF A
    cmp nra, 0
    je skipToRepeta2
    repeta2:
        mov Al, [SI]
        mov c[BP], AL
        inc SI
        inc BP
        dec nra
    loopne repeta2


    skipToRepeta2:
    ;LOOP THROUGH THE REST OF B
    cmp nrb, 0
    je final
    repeta3:
        mov Al, [DI]
        mov c[BP], AL
        inc DI
        inc BP
        dec nrb
    loopne repeta3

    final:

    mov AX, 4c00h
    int 21h


code ends
end start
