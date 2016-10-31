assume DS: data, CS: code
data segment
    a DW 3
    b DW 7
    x DW 0
data ends
code segment
start:
    mov AX, data
    mov DS, AX

    mov AX, a ; AL := a = 3
    add AX, b ; Al := Al + b=3 + 7=10
    mov x, AX


    mov AX, 4C00h
    int 21h
code ends
end start
