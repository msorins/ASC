; 5. Read the numbers a, b and c and compute and print on the screen a+b-c.

assume CS: code, DS: data
data segment
  maxSize db 100
  readLength db ?
  readStr db 100 dup (?)
  nr dw 0
  a dw 0
  b dw 0
  c dw 0
  sum dw ?
  sumSir db 100 dup (?)
  flag dw 0
  counter dw 0

data ends
code segment
start:
    mov AX, data
    mov DS, AX

    readA:
    mov flag, 1
    jmp read
    readAreturn:
    mov AX, nr
    mov a, AX

    readB:
    mov flag, 2
    jmp read
    readBreturn:
    mov AX, nr
    mov b, AX

    readC:
    mov flag, 3
    jmp read
    readCreturn:
    mov AX, nr
    mov c, AX

    jmp suma

    read:
    ; === READ SEQUENCE into readStr ===
    mov AH, 0Ah
	  mov DX, offset maxSize
	  int 21h

    ; put readStr into DS:SI
    mov AX, seg readLength
    mov DS, AX
    mov SI, offset readStr

    ; put length of readStr into CX
    mov CL, readLength
    mov CH, 0

    mov nr, 0
    repeat:
        ;Load into AL current byte from DS:SI, increment SI
        lodsb

        ;Convert from ASCII
        sub AL, '0'

        ;Backup the value from AL to BL
        mov BL, AL
        mov BH, 0

        ; DX:AX = AX * 10
        mov AX, nr
        mov DX, 10
        mul DX

        add AX, BX
        mov nr, AX
    loop repeat

    ;THE NUMBER THAT IS READ IS PUT INTO NR
    mov AX, flag

    cmp AX, 1
    JE readAreturn

    cmp AX, 2
    JE readBreturn

    cmp Ax, 3
    JE readCreturn


    suma:
        mov AX, a
        add AX, b
        sub AX, c

        ;THE FINAL RESULT IS HERE
        mov sum, AX


    convertNrToSTR:
    ;put sumSir into ES:DI
    mov AX, seg sumSir
    mov ES, AX
    mov DI, offset sumSir

    ;put into BX the sum result from above
    mov BX, sum

    ;initialise the CX value
    mov counter, 0
    repeat2:
        ;CONVERT AX INTO DX:AX
        mov DX, 0
        mov AX, BX
        mov CX, 10

        ;DX := DX:AX % 10 , AX := DX:AX / 10
        div CX

        ;Prepare the new number without the last digit
        mov BX, AX

        ;Put the last digit into AL
        mov AL, DL
        mov AH, 0

        ;PUT in ES:DI the byte from AL, increment SI
        stosb
        inc counter

        cmp BX, 0
        JE exitRepeat2
    JMP repeat2

    exitRepeat2:
    print:
    ;Print new line
    mov DL, 10
    mov AH, 02h
    int 21h

    mov CX, counter

      repeat3:
          ;PUT INTO AL THE CURRENT DIGIT TO PRINT
          mov BX, CX
          dec BX
          mov AL, sumSir[BX]

          ;CONVERT AL TO ASCII
          add AL, '0'

          ;PRINT IT
          mov AH, 02h
          mov DL, AL
          int 21h
      loop repeat3


    mov AX, 4c00h
    int 21h
code ends
end start
