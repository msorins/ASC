;4. 9. Being given a string of doublewords, build another string of doublewords which will include only the
;      doublewords from the given string which have an even number of bits with the value 1.

assume DS: data, CS: code
data segment
    a db ?
    sir  dd  0ffffafafh, 0abcd0h, 2218acach, 7a082ae3h, 0c820ddd1h, 7828ddd1h, 0c8d8ddd1h, 0c8b0ddd1h, 7260ddd1h, 2a70ddd1h, 7850ddd1h, 0c840ddd1h
    len equ ($-sir)/4
    evenNumbers db 0
data ends
code segment
start:
    mov AX, data
    mov DS, AX

    mov si, offset sir	;in ds:si we will store the FAR address of the string "sir"
    cld ; loop the string from left to right
    mov cx, len	 ; len iterations will be

    repeta:
        lodsw
        mov BX, AX
        lodsw

        XOR AX, BX

        JP Odd
        ;Here the number is Even
        add evenNumbers, 1
        Odd:
    loop repeta

    mov AX, 4C00h
	int 21h
code ends
end start
