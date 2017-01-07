; 4. A string of numbers is given. Print on the screen the values in base 16.
assume CS: code, DS:data
data segment public
    sir db 100 dup(?)
    sir2 db 100 dup(?)
data ends

code segment public
;External Procedures
extrn readf: proc
extrn convert: proc
extrn printf: proc

start:
    mov AX, data
    mov DS, AX

    ;Read String
    mov AX, seg sir
    mov BX, offset sir
    call readf

    ;Convert string of numbers to base 16
    mov AX, seg sir
    mov BX, offset sir
    mov CX, offset sir2
    call convert

    ;Print base16 numbers from sir2
    mov AX, seg sir
    mov BX, offset sir2
    call printf

    mov AX, 4c00h
    int 21h
code ends
end start
