;4. Print the current date on the screen and also the current day of the week (using letters, not numbers).
assume DS: data, CS:code
data segment
    msgDate db 'Current date: $'
    msgSeparator db ' / $'
    msgNewLine db ' \n $'
    msgDay db 'Today is: $'
    year dw ?
    yearStr db 10 dup(?)
    month db ?
    day db ?
    daysStr db ' Luni Marti Miercuri Joi Vineri Sambata Duminica $'
    weekDay db ?
    c1 db ?
    c2 db ?
data ends
code segment
start:
    mov AX, data
    mov DS, AX


    ;PRINT msgDate
    mov AH, 09h
    mov DX, offset msgDate
    int 21h


    ;GET CURRENT DATE
    ;CX YEAR
    ;DH MONTH
    ;DL DAY
    ;AL DAY OF WEEK
    mov AH, 2ah
    int 21h

    mov year, CX
    mov month, DH
    mov day, DL
    mov weekDay, AL

    ;---------- Print DAY ----------
    mov AL, day
    mov AH, 0
    mov BL, 10
    div BL

    ;Get the numbers separately
    mov c1, AH
    mov c2, AL

    ;Convert them to ASCII
    add c1, '0'
    add c2, '0'

    ;Print them
    mov AH, 02h
    mov DL, c2
    int 21h

    mov AH, 02h
    mov DL, c1
    int 21h


    ;---------- PRINT msgDate ---------
    mov AH, 09h
    mov DX, offset msgSeparator
    int 21h

    ;---------- Print MONTH ----------
    mov AL, month
    mov AH, 0
    mov BL, 10
    div BL

    ;Get the numbers separately
    mov c1, AH
    mov c2, AL

    ;Convert them to ASCII
    add c1, '0'
    add c2, '0'

    ;Print them
    mov AH, 02h
    mov DL, c2
    int 21h

    mov AH, 02h
    mov DL, c1
    int 21h

    ;---------- PRINT msgDate ---------
    mov AH, 09h
    mov DX, offset msgSeparator
    int 21h

    ;---------- Print YEAR ----------

    ;Move yearStr into ES:DI
    mov DI, offset yearStr
    mov AX, seg yearStr
    mov ES, AX
    cld

    ;Transform the year into a reversed string of ASCII characters (ready to be printed)
    mov CX, 4
    Repeta:
        mov AX, year

        mov BL, 10
        div BL

        mov BL, AL
        mov AL, AH
        add AL, '0'
        stosb ; Store AL ( the last digit from modulo 10 ) into the str
        mov AL, Bl

        mov AH, 0
        mov year, AX

    loop Repeta

    ;Actually print the string
    mov SI, offset yearStr
    add SI, 3
    mov AX, seg yearStr
    mov DS, AX
    std

    mov CX, 4
    Repeta2:
        lodsb ; Load into AL the DS:SI

        mov AH, 02h
        mov DL, AL
        int 21h

    loop Repeta2


    ;---------- PRINT NEW LINE ---------
    mov DL, 10
    mov AH, 02h
    int 21h

    ;---------- PRINT STRING MESSAGE DAY ---------
    mov AH, 09h
    mov DX, offset msgDay
    int 21h

    ;---------- Print DATE BY STRING ----------
    mov SI, offset daysStr
    mov AX, seg daysStr
    mov DS, AX
    cld

    mov BL, 0 ; Contor


    Repeta3:
        lodsb ; Load into AL the DS:SI

        cmp AL, ' '
        JNE notEmptySpace
        ;Here the current character it is EMPTY SPACE
        add BL, 1
        JMP sfLoop3
        notEmptySpace:

        cmp BL, weekDay
        JG sfProg
        JNE sfLoop3

        ;Here i have to print the current character
        mov AH, 02h
        mov DL, AL
        int 21h

        sfLoop3:
    loop Repeta3

    sfProg:
    
    mov AX, 4c00h
    int 21h
code ends
end start
