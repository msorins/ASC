; 9. (a-b+c*128)/(a+b)+e
; a,b-byte, c-word, e-doubleword
; UNSIGNED
assume DS: data, CS: code
data segment
    a DB 12
    b DB 2
    C DW 2
    e DD 1000000000
data ends
code segment
start:
    mov AX, data
    mov DS, AX

    mov BL, a ; BL := a = 12
    sub BL, b ; BL := BL - b = 12 - 2 = 10
    mov BH, 0 ; converting byte to word, forming BX

    mov CX, 128 ; CX := 128
    mov AX, c ; AX := c = 2
    mul CX ; DX:AX := AX * CX = 2 * 128 = 256

    add AX, BX ; AX := AX + BX = 256 + 10 = 266

    mov BL, a ;  BL := a = 12
    add BL, b ;  Bl := BL + b = 12 + 2 = 14
    mov BH, 0 ; converting byte to word, forming BX

    mov DX, 0 ; converting AX to DX:AX (doubleword)

    div BX ; AX := DX:AX / BX = 266 / 14 = 19

    mov DX, 0 ; converting AX to DX:AX (doubleword)

    ;Forming CX:BX
    mov BX, word ptr e
    mov CX, word ptr e + 2

    ;Adding to double words, DX:AX with CX:BX, result is in DX:AX
    add AX, BX
    adc DX, CX


    mov AX, 4c00h
    int 21h
code ends
end start
