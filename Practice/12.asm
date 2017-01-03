;5. Two byte string S1 and S2 are given, having the same length.
;Obtain the string D by intercalating the elements of the two strings.
;Exemple:
;S1: 1, 3, 5, 7
;S2: 2, 6, 9, 4
;D: 1, 2, 3, 6, 5, 9, 7, 4


assume CS: code, DS: data
data segment
  s1 db 1, 3, 5, 7
  s2 db 2, 6, 9, 4
  len EQU $-s2
  s3 db 10 dup (?)
  c dw 0
  c2 dw 0
data ends
code segment
start:
  mov AX, data
  mov DS, AX

  mov CX, len

  repeta:
    ;put into AL current nr from s1
    ;put into DL current nfr from s2
    mov BX, c
    mov AL, s1[BX]
    mov DL, s2[BX]
    inc c

    ;put AL and BL into S3
    mov BX, c2
    mov s3[BX], AL
    inc BX
    mov s3[BX], DL

    inc c2
    inc c2
  loop repeta


  mov AX, 4c00h
  int 21h
code ends
end start

bx/bp + si/di
