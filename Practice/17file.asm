assume CS: code, DS:data
data segment public
    fName dw ?
    fSeg dw ?
    fContent dw ?
    handler dw ?
    crt dw 0
    msgOpenError db 'Error when opening the file$'
    fileC db 2000 dup(?)
    charactersRead dw ?
data ends

code segment public
public filef
filef:
    ; INPUT
    ; AX - fSegment
    ; BX - fName (file name)
    ; BX - fContent (file content)
    push DX

    ;Input
    mov fSeg, AX
    mov fName, BX
    mov fContent, CX

    ;Open File
    mov AH, 3Dh
    mov AL, 0 ; Read Only
    mov DX, fName ; fName is already an offset
    int 21h

    jc openError ;
    mov handler, AX

    ;Load in ES:DI the fContent
    mov ES, fSeg
    mov DI, fContent

    ;Read from the file
    repeat:
        mov AH, 3Fh
        mov BX, handler
        mov CX, 100
        mov DX, offset fileC
        int 21h

        ;Load in DS:SI the fileC
        mov CX, data
        mov DS, CX
        mov SI, offset fileC

        ;Number of steps
        mov CX, AX
        mov charactersRead, AX

        ;Add the content to the input parameter
        repeat2:
            lodsb
            stosb
        loop repeat2

        ;End condition
        mov AX, charactersRead
        cmp AX, 100
    JE repeat
    JMP endFile

    openError:
        mov AH, 09h
        mov DX, offset msgOpenError
        int 21h

    endFile:
        pop DX
        ret
code ends
end
