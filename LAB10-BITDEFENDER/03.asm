[bits 32]

section .text 

extern  _printf
extern _exit

global  _main 

_main: 
		mov EAX, 0
		mov ESI, 0
		mov ECX, len
		
		REPEAT:
			mov EBX, sir[ESI]
			cmp EBX, 0
			
			JGE SFREPEAT
			;HERE EBX IS SMALLER THAN 0
			NEG EBX
			
			SFREPEAT:
			add EAX, EBX
			add ESI, 4
		loop REPEAT
	


		;PRINTING PROCEDURE
		push	DWORD EAX
        push    DWORD text 
        call    _printf
        add     esp, 8
        push    0
        call    _exit
        ret 

section .data

text:   db      'Suma modlulelor este: %d',0
sir: dd 1, -10, 5, 2, 5, 0, -9, 17
len: EQU ($-sir)/4 