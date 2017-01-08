assume CS:code, DS:data
data segment public
    maxLength db 100
    readSize db ?
    readStr db 100 dup(?)
    inputSeg dw ?
    inputOff dw ?
data ends

code segment public
public readf
readf:
    ; INPUT
    ; AX - string Segment
    ; BX - string Offset
    push CX
    push DX

    mov inputSeg, AX
    mov inputOff, BX

    ;Actually read the string
    mov AH, 0Ah
    mov DX, offset maxLength
    int 21h

    ;Move the string to the input location zone

    ;Load readStr in DS:SI
    mov AX, seg readStr
    mov DS, AX
    mov SI, offset readStr

    ;Load input into ES:DI
    mov ES, inputSeg
    mov DI, inputOff

    ;Number of repetitions
    mov CL, readSize
    mov CH, 0

    ;Loop through the string
    repeat:
        movsb; Byte from DS:SI is put into ES:DI, SI and DI are incremented
    loop repeat

    ;Add a 0 at the end to transform it in an ASCIIZ
    mov AL, 0
    stosb

    ;Print a new line
    mov AH, 2h
    mov DL, 10
    int 21h

    pop DX
    pop CX
    ret
code ends
end
