;9. The word A and the byte B are given. Obtain the byte C in the following way:
;- the bits 0-3 of C are the same as the bits 6-9 of A
;- the bits 4-5 of C have the value 1
;- the bits 6-7 of C are the same as the bits 1-2 of B
assume DS: data, CS: code
data segment
    a DW 52886
    b DB 110
    c DB 0
data ends
code segment
start:
    mov AX, data
    mov DS, AX

    ;Isolate the bits 6-9 of A
    mov AX, 960
    and AX, a ;

    ;Rotate the bits 6-9 to positition 0-3
    mov CL, 6
    ror AX, CL

    ;Put bits 0-3 in result C
    or c, AL

    ;Put bits 1 in position 4-5 in result c
    or c, 00110000b

    ;Isolate the bits 1-2 of B
    mov AL, 6
    and Al, b

    ;Rotate the bits 1-2 to position 6-7
    mov CL, 5
    rol AL, CL

    ;Put the bits 6-7 in result c
    or c, AL





    mov AX, 4c00h
    int 21h
code ends
end start
