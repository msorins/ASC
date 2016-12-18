;1. Suma a doua numere
[bits 32]

section .text 

extern  _printf
extern _exit

global  _main 

_main:
		mov EAX, [a]
		add EAX, [b]
		
		push 	DWORD EAX 
        push    DWORD text 
		
        call    _printf
		
        add     esp, 4 * 2
        push    0
        call    _exit
        ret 

section .data

text:   dd      'Le suma este: %d',0 
a: dd 15
b: dd 20
