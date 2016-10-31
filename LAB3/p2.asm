;2) (d+2*a)/b
assume DS: data, CS: code
data segment
    a DB 6
    b DB 7
    d DW 2
    x DB 2
data ends
code segment
start:
    mov AX, data
    mov DS, AX

    mov Al, a ; Al := a = 6
    mul x ; AX := AL * 2 = 12

    add AX, d; AX := AX + 2 = 12 + 2 = 14
    div b;
     

    mov AX, 4c00h
    int 21h
code ends
end start
