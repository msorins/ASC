;56)  ((a*d)+b)-c
assume DS: data, CS: code
data segment
    a DB 2
    b DW 7
    c DW 1
    d DB 2
data ends
code segment
start:
    mov AX, data
    mov DS, AX

    mov AL, a ; AL := a  = 2
    mul d  ; AX := AL * d = 2 * 2 = 4

    add AX, b; AX := AX + b = 4 + 7 = 11
    sub AX, c; AX := AX - c = 11 - 1 = 10




    mov AX, 4c00h
    int 21h
code ends
end start
