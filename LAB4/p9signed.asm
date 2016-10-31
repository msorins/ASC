; 9. (a-b+c*128)/(a+b)+e
; a,b-byte, c-word, e-doubleword
; SIGNED
assume DS: data, CS: code
data segment
    a DB 12
    b DB 2
    c DW 2
    e DD 10000000
data ends
code segment
start:
    mov AX, data
    mov DS, AX

    ;COMPUTING a-b => CX:BX := 10
    mov BL, a; BL := a = 12
    sub BL, b; BL := BL - b = 12 - 2 = 10
    mov BH, 0; CONVERT BYTE TO WORD => BX := 10
    mov CX, 0; CONVER WORD TO DWORD => CX:BX := 10

    ;COMPUTING c*128 => DX:AX := 256
    mov DX, 128; DX := 256
    mov AX, c; AX  := c = 2
    imul DX ; DX:AX := AX * DX = 2 * 256

    ;COMPUTIING a-b+c*128 => DX:AX := 266
    add AX, BX
    adc DX, CX

    ;COMPUTING a+b => CX := 14
    mov CL, a ; CL := a = 12
    add CL, b ; CL := CL + b  = 12 + 2 = 14
    mov CH, 0 ; CONVERT BYTE TO WORD => CX := 14

    ;COMPUTING (a-b+c*128)/(a+b) => AX := 266 / 14 = 19
    IDIV CX

    mov DX, 0 ; CONVERT WORD TO DWORD => DX:AX = 19

    ;COMPUTE (a-b+c*128)/(a+b)+e => CX:BX = 1000000019

    add AX, word PTR e
    adc DX, word PTR e+2

    mov AX, 4c00h
    int 21h
code ends
end start
