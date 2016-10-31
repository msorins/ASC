;10. Replace the bits 0-3 of byte B with the bits 8-11 of word A.
assume DS: data, CS: code
data segment
    a DW 52886
    b DB 110
data ends
code segment
start:
    mov AX, data
    mov DS, AX

    ;Isolate bits 8-11 of word A
    mov AX, 3840
    and AX, a

    ;Move bits 8-11 to position 0-3
    mov CL, 8
    ror AX, CL

    ;Clear the bits 0-3 of byte b
    and b, 1110000b

    ;Move the bits 0-3 of AX to b
    or b, AL



    mov AX, 4c00h
    int 21h
code ends
end start
