;5. Being given a string of bytes representing a text (succession of words separated by spaces)
;determine which words are palindromes (meaning may be interpreted the same way in either forward or reverse direction);
;ex.: "cojoc", "capac" etc.

assume DS: data, CS: code
data segment
    sir db "cojoc capac uac bac abccba"
    len EQU $-sir
    nrWords db 0
    nrLetters db 0
    li dw 0
    lf dw 0
    nrPalindroms db 0
    doi db 2
data ends
code segment
start:
    mov AX, data
    mov DS, AX

    ;Store number of steps in CX
    mov CX, len

    ;Store sir in DS:SI
    mov SI, offset sir
    mov AX, seg sir
    mov DS, AX

    cld ; clear the direction flag (Direction from left to right)

    repeta:
        lodsb ; the byte from DS:SI is stored into AL, SI is incremented by one

        cmp AL, " "
        JNE letter ; Jump if current character is a letter

        ; If current character is space !!!!
        add nrWords, 1 ; Increment number of words
        mov BX, CX ; Save CX in BX

        ;Number of steps of repeta2 = Number of letters of current word divided by 2
        prepareRepeta2:
            mov AL, nrLetters
            mov AH, 0
            div doi
            mov Cl, AL
            mov CH, 0

            ;Decrement LF by 1
            sub lf, 1

            jmp repeta2

        resumeIfPalindrom:
            mov CX, BX ; Restore CX from BX

            add nrPalindroms, 1

            ;Special Case, if there is a jump from the last word
            cmp CX, 0
            je sfarsit

            mov nrLetters, 0 ; Numbers of letters reinitialised
            mov li, SI

            loop repeta;CX is decremented by one

        resumeIfNotPalindrom:
            mov CX, BX ; Restore CX from BX

            ;Special Case, if there is a jump from the last word
            cmp CX, 0
            je sfarsit

            mov nrLetters, 0 ; Numbers of letters reinitialised
            mov li, SI
            loop repeta;CX is decremented by one

        letter:
            add nrLetters, 1
            mov lf, SI

    loop repeta ;CX is decremented by one

    mov BX, 0
    jmp prepareRepeta2 ; Cafe if the last word is a palindrom

    repeta2:
        ;Store first character in AL
        mov BP, li
        mov AL, sir[BP]

        ;Store last character in AH
        mov BP, lf
        mov AH, sir[BP]

        ;Compare and go back if numbers are not palindrom
        cmp AH, AL
        jne resumeIfNotPalindrom

        inc li
        dec lf
    loop repeta2
    jmp resumeIfPalindrom ; If we get here it means that the number is palindrom

    mov AL, nrWords

    sfarsit:

    mov AX, 4C00h
    int 21h
code ends
end start
