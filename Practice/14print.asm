assume DS: data, CS:code

data segment public
    rSirOff dw ?
    rSirSeg dw ?
data ends

code segment public
public printf

printf:
    ;INPUT
    ; AX - OFFSET rSir
    ; BX - SEGMENT rSir
    push CX
    push DX

    ;Load string into DS:SI
    mov DS, BX
    mov SI, AX

    repeat:
        lodsb; Load DS:SI into AL, increment SI

        ;Check if the string still has characters
        cmp AL, 0
        JE endRepeat

        ;Print intrerrupt
        mov AH, 02h
        mov DL, AL
        int 21h
    JMP repeat
    endRepeat:

    ;Print new line
    mov DL, 10
    mov AH, 02h
    int 21h

    pop DX
	  pop CX
	  ret
code ends
end
