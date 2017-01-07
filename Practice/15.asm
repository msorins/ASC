;8. Print of the screen, for each number between 32 and 126, the value of the number (in base 10) and the character whose ASCII code the number is.
assume CS: code, DS:data
data segment public
    sir db 100 dup(?)
data ends

code segment public

;External prodcedures
extrn readf: proc
extrn printf: proc

start:
    mov AX, data
    mov DS, AX

    ;Read sir of integers
    mov AX, seg sir
    mov BX, offset sir
    call readf

    ;Print sir of integers in base 10
    mov AX, seg sir
    mov BX, offset sir
    call printf

    mov AX, 4c00h
    int 21h
code ends
end start
