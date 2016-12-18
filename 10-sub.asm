assume CS:code, DS:data

data segment public
    a db ?
    nr dw ?
    rez db 12 dup(?)
    lenRez db 0
    rezInversed db 12 dup(?)
    startPoz db ?
    crtPoz db ?
    auxCX dw ?
data ends

code segment public
extrn printf:proc ; Declare the external subf - procedure
public subf	; the subprogram 'subf' is made visible to other modules too
subf:
; input: AL = the number that has to be printed on the screen
; the subprogram prints the number on the screen
; it does not modify the registers, except for ax

; we save the registers so that we can use them inside the subprogram
	push bx
	push cx
	push dx

    ;Save input number (AX) into nr
    mov nr, AX

    ;PUT rez into ES:DI
    mov DI, offset rez
    mov AX, seg rez
    mov ES, AX

    ; --- convert base 10 number to base 16 (put it in rez) ---

    ;REPEAT WHILE
    repeta:
        ;Divide by 16 the number
        mov AX, nr
        mov BL, 16
        div BL ; AH - rest , AL - rez

        ;Put the result back into the variable nr
        mov BL, AL
        mov BH, 0
        mov nr, BX

        ;Put the rest into ES:DI
        mov AL, AH ;
        stosb; Store AL into ES:DI, increment DI

        ;Increment the number of 16base digits
        inc lenRez

        ;Test condition to exit the loop
        cmp nr, 0
        JE exitRepeta
    JMP repeta

    exitRepeta:

    ; --- form rezInversed from rez ---

    ;Loop through rez from the end
    mov BL, lenRez
    mov BH, 0
    mov BP, BX
    dec BP

    ;Put rezInversed into ES:DI
    mov DI, offset rezInversed
    mov AX, seg rezInversed
    mov ES, AX

    ;Put Number Of Steps into CX
    mov AL, lenRez
    mov AH, 0
    mov CX, AX
    repeta1:
        mov AL, rez[BP]
        stosb; Store AL into ES:DI, increment DI

        dec BP; Decrement BP

    loop repeta1

    ; --- print all circular permutations of rezInversed ---
    
    ;Print new line
    mov DL, 10
    mov AH, 02h
    int 21h

    mov AL, lenRez
    mov AH, 0
    mov CX, AX

    mov startPoz, 0
    repeta2:
        mov auxCX, CX ; BackUp value of CX

        ;Initialize startPozition with crtPoz
        mov BL, startPoz
        mov crtPoz, BL

        ;Number of steps
        mov AL, lenRez
        mov AH, 0
        mov CX, AX

        repeta3:
            ;Put crtPoz into BP in order to print it
            mov BL, crtPoz
            mov BH, 0
            mov BP, BX

            ;Print the character
            mov AL, rezInversed[BP]
            call printf

            ;Increment the pozition
            inc crtPoz

            ;Make modulo of position
            mov AL, crtPoz
            mov AH, 0
            div lenRez

            ;The rest will be the new crtPoz
            mov crtPoz, AH
        loop repeta3

        ;Print new line
        mov DL, 10
        mov AH, 02h
        int 21h

        ;Increment the start string pozition and do everything all over again
        inc startPoz
        mov CX, auxCX ; Restore value of CX
    loop repeta2



    ;Ending instructions
    final:
    pop dx
	pop cx
	pop bx

	ret

code ends
end
