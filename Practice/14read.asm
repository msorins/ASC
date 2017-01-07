assume CS: code, DS: data

data segment
    maxNumberSize db 101
    readLength db ?
    readStr db 100 dup(?)
    sirDestSeg dw ?
    sirDestOff dw ?
data ends


code segment public

public readf

readf:
    push DX

    ;in AX is the offset of dest string
    ;int BX is the segment of dest string
    mov sirDestOff, AX
    mov sirDestSeg, BX

    ;Read a string
    mov AH, 0ah
	  mov DX, offset maxNumberSize
	  int 21h

    ;Load the readStr into DS:SI
    mov AX, data
    mov DS, AX
    mov SI, offset readStr

    ;Load the destination String into ES:DI
    mov ES, sirDestSeg
    mov DI, sirDestOff

    mov CL, readLength
    mov CH, 0

    cmp CX, 0
    JE final
    repeat:
        movsb
    loop repeat

    ;Final module operations
    final:
    pop DX
    ret
code ends
end
