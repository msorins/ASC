; Set par variable to 0 if number is even, else set it to 0
assume CS:code, DS: data
data segment
    a db 17
    par db ?
data ends
code segment
start:
    mov AX, data
    mov DS, AX

    mov AL, 1
    AND AL, a

    CMP AL, 0
    JG impar
    mov par, 0

    impar:
        mov par, 1


    mov AX, 4c00h
    int 21h
code ends
end start
