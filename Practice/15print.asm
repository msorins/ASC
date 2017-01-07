assume CS: code, DS: data

data segment public
    auxSir db 10 dup (?)
    nr db ?
    len db ?
data ends

code segment public
public printf

printf:
    ; INPUT
    ; AX - SEG SIR
    ; BX - OFFSET SIR
    push CX
    push DX

    ;put AX:BX into DS:SI
    mov DS, AX
    mov SI, BX

    ;Print new line
    mov AH, 02h
    mov DL, 10
    int 21h
    
    repeat:
        lodsb ; Load DS:SI into AL, increment SI

        ;Check if sir is at the end
        cmp AL, 0
        JE sfPrintf

        mov nr, AL
        jmp printNumber
        backPrintNumber:

    JMP repeat

    printNumber:
        push DS
        push SI

        ;put auxSir into ES:DI
        mov AX, seg auxSir
        mov ES, AX
        mov DI, offset auxSir

        ;TRANSFORM NUMBER TO STRING

        ;Put nr into AL
        mov AL, nr
        mov AH, 0

        ;Count number of digits
        mov CX, 0
        repeat2:
            mov BL, 10
            div BL ; AL:= AL / 10 , AH := AH % 10
            mov nr, AL

            mov AL, AH
            stosb; Put AL into ES:DI

            ;Increment the number of digits
            inc CX

            ;Compare nr to check that it is diffrent than 0
            mov AL, nr
            mov AH, 0
            cmp nr, 0
            JE sfRepeat2


        JMP repeat2
        sfRepeat2:

        ;PRINT FORMED STRING IN INVERSE ORDER

        ;put auxSir into DS:SI
        mov AX, seg auxSir
        mov DS, AX
        mov SI, offset auxSir
        add SI, CX
        dec SI


        ;print all the digits
        std ; Set direction flag to 1
        repeat3:
            lodsb; LOAD DS:SI into AL
            add AL, '0'

            ;Print the digit
            mov AH, 02h
            mov DL, AL
            int 21h
        loop repeat3
        cld ; Set direction flag to 1

        ;Print new line
        mov AH, 02h
        mov DL, 10
        int 21h

        ;Finishing printing procedure (of a complet number)

        pop SI
        pop DS
        JMP backPrintNumber

    sfPrintf:
        pop DX
        pop CX
        ret
code ends
end
