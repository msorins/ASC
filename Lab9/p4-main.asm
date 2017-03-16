;4. A string of numbers is given. Print on the screen the values in base 16.
assume CS: code, DS: data

data segment public
    sir db 8, 10, 201, 243, 176, 13, 255, 101
    len EQU $-sir
    auxSI dw ?
data ends

code segment public
extrn subf:proc ; Declare external sub procedure
start:
    mov AX, data
    mov DS, AX

    ;MOV sir INTO DS:SI
    mov SI, offset sir
    mov AX, seg sir
    mov DS, AX

    mov CX, len ; number of repeats for loop

    repeta:
        lodsb ; load current element from DS:SI into AL, increment SI
        mov AH, 0
        mov auxSI, SI ; Save SI into auxSI
        call subf

        ;Print 'h' letter
        mov AH, 02h
        mov DL, 'h'
        int 21h

        ;Print new line
        mov DL, 10
        mov AH, 02h
        int 21h

        ;Restore SI from auxSI
        mov SI, auxSI


    loop repeta

    mov AX, 4c00h
    int 21h
code ends
end start
