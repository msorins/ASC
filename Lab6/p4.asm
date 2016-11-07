;4. A byte string S of length l is given.
;Obtain the string D of length l-1 so that the elements of D represent the difference between every two consecutive elements of S.
;Exemple:
;S: 1, 2, 4, 6, 10, 20, 25
;D: 1, 2, 2, 4, 10, 5

assume DS: data, CS: code
data segment
    s DB 1, 2 , 4, 6, 10, 20, 25
    l EQU $-s
    d db l dup (0)
data ends
code segment
start:
    mov AX, data
    mov DS, AX

    mov CX, l ; put the length of the string in CX
    sub CX, 1 ; decrement the value with one
    mov SI, 0 ;

    jcxz Sfarsit
    Repeta:
    ; ---WHILE BEGINS---

    mov AL, s[SI+1]
    sub AL, s[SI]
    mov d[SI], AL

    inc SI      ;we go to the next byte within the string
    loop Repeta
    Sfarsit:      ;end of program


    mov AX, 4c00h
    int 21h
code ends
end start
