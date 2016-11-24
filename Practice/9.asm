;13. Being given a string of bytes and a substring of this string, eliminate all occurrences of this substring from the initial string.
assume DS: data, CS:code
data segment
    sir db 'la bac vreau sa zbac un drbac'
    lensir EQU $-sir
    subsir db 'bac'
    lensubsir EQU $-subsir
    gasit db 0
data ends
code segment
start:
    mov AX, data
    mov DS, AX

    ;Move sir into DS:SI
    mov SI, offset sir
    mov AX, seg sir
    mov DS, AX

    ;Number of steps
    mov CX, lensir

    repeta:
        ;Mov subsir into ES:DI
        mov DI, offset subsir
        mov AX, seg subsir
        mov ES, AX

        ;Save value of CX into BX and of SI into DX
        mov BX, CX
        mov DX, SI

        mov CX, lensubsir
        mov gasit, 0
        repeta2:
            cmpsb ; Compare value from DS:SI with ES:DI, increment SI and DI
            JNE sfRepeta

        loop repeta2
        ;If execution is here than substring is found into string.
        mov CX, BX
        mov SI, DX
        repeta3:
            mov BP, SI
            add BP, lensubsir
            mov AL, sir[BP]

            stosb; store byte from AL into DS:SI !!!! TO CHANGE HEREE

        loop repeta3

        ;Restore value from BX into CX and from DX into SI
        sfRepeta:
            mov CX, BX
            mov SI, DX
            lodsb; Load into AL the location of DS:SI, but MAINLY increment SI


    loop repeta

    ;TO FINISH
    mov AX, 4c00h
    int 21h
code ends
end start
