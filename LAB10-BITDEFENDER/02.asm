[bits 32]

section .text 

extern  _printf
extern _exit
;2. Cel mai mare divizor comun
global  _main 

_main: 
		mov EAX, [a]
		mov EBX, [b]
		
		START:
		CMP EAX, EBX
		JE FINAL
		
		JNB NOTBELOW
		;HERE EAX < EBX
		SUB EBX, EAX
		JMP START
		
		NOTBELOW:
		;HERE EAX >= EBX
		SUB EAX, EBX
		
		JMP START
		
		
		FINAL:
			PUSH 	DWORD EAX
			push    DWORD text 
			call    _printf
			add     esp, 8
			push    0
			call    _exit
			ret 

section .data

text:   dd      'GCD is: %d',0 
a dd 250
b dd 7215