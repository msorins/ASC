assume CS: code, DS:data
data segment
a db 5
b dw 6
x db 0
sir db 10 dup (9)

data ends
code segment
start:
    mov AX, data
    mov DS, AX

    lea AX, [BX+SI+a+b]
    int 21h
code ends
end start
