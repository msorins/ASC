assume DS:data, CS:code
data segment
    a DB 3
    b DB 2
    c DB 5
    d DW 4
    X DW 0
data ends

code segment
start:
    mov AX, data
    mov DS, AX

    mov AL, a ;AL := A = 3
    add AL, B ;AL := AL + 2 = 5
    mul c ; AX = AL * C = 5 * 5 = 25

    mov DX, 0
    div d;

    mov x, AX
code ends
end start
