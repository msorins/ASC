;3. Two character strings are given. Compute and print on the screen the result of the concatenation of the second string
; after the first one, and also of the first string after the second one.

assume CS: code, DS: data
data segment public
    sir1 db 100 dup(?)
    sir2 db 100 dup(?)
    sir3 db 200 dup(?)
    sir4 db 200 dup(?)
data ends

code segment public

;Declare the procedures (aka subprograms)
extrn readf:proc
extrn concatenate:proc
extrn printf: proc

start:
    mov AX, data
    mov DS, AX

    ;READ SIR1
    mov AX, offset sir1
    mov BX, seg sir1
    call readf

    ;READ SIR2
    mov AX, offset sir2
    mov BX, seg sir2
    call readf

    ;CONCATENATE sir2 TO sir1 => result in sir3
    mov AX, offset sir1
    mov BX, offset sir2
    mov CX, offset sir3
    mov DX, seg sir1
    call concatenate

    ;CONCATENATE sir1 TO sir2 => result in sir4
    mov AX, offset sir2
    mov BX, offset sir1
    mov CX, offset sir4
    mov DX, seg sir1
    call concatenate

    ;PRINT sir3
    mov AX, offset sir3
    mov BX, seg sir3
    call printf

    ;PRINT sir4
    mov AX, offset sir4
    mov BX, seg sir4
    call printf

    mov AX, 4c00h
    int 21h
code ends
end start
