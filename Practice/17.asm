; Read from the keyboard the name of the file (string), then a word (string)
; Open that file and count all the occurrences of that word in the file content
assume CS:code, DS:data
data segment public
    file db 100 dup(?)
    fileContent db 2000 dup(?)
    subs db 100 dup(?)
    msg1 db 'Name of the file to be opened: $'
    msg2 db 'String to find in file: $'
data ends

code segment public
;Declared segments are here
extrn readf: proc
extrn filef: proc
extrn compute: proc

start:
    mov AX, data
    mov DS, AX

    ; ==============================

    ;Print msg1 to the console
    mov AH, 09h
    mov DX, offset msg1
    int 21h

    ;Print new line
    mov AH, 02h
    mov DL, 10
    int 21h

    ;Read file string
    mov AX, seg file
    mov BX, offset file
    call readf

    ; ==============================

    ;Print msg1 to the console
    mov AH, 09h
    mov DX, offset msg2
    int 21h

    ;Print new line
    mov AH, 02h
    mov DL, 10
    int 21h

    ;Read word string
    mov AX, seg subs
    mov BX, offset subs
    call readf

    ; ==============================

    ;Put in fileContent the content of that file
    mov AX, seg fileContent
    mov BX, offset file
    mov CX, offset fileContent
    call filef


    ; ==============================
    ;Compute the number of aparitions of a substring in a string
    ;
    
    mov AX, seg fileContent
    mov BX, offset fileContent
    mov CX, offset subs
    call compute




    mov AX, 4c00h
    int 21h
code ends
end start
