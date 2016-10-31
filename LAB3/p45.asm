;45) (c+b+b)-(c+a+d)
assume DS: data, CS: code
data segment
    a DW 1
    b DW 5
    c DW 3
    d DW 4
data ends
code segment
start:
    mov AX, data
    mov DS, AX

    mov AX, a; AX := a = 1
    add AX, b; AX := AX + b = 1 + 5 = 6
    add AX, b; AX := AX + b = 6 + 5 = 11

    mov BX, c; BX := c = 3
    add BX, a; BX := BX + a = 3 + 1 = 4
    add BX, d; BX := BX + d = 4 + 4 = 8

    sub AX, BX ; AX := AX - BX = 11 - 8 = 3


    mov AX, 4c00h
    int 21h
code ends
end start
