[bits 32]

section .text 

extern __time32
extern  _printf
extern _exit
extern _getchar

global  _main 

_main: 
	
	repeta:
			call _getchar
			;returned value in EAX
			
			cmp EAX, -1
			JE final
			
			;GET THE CURRENT TIME
			push dword 0
			call __time32
			add ESP, 4
			;IN EAX THERE IS THE CURRENT TIME
			
			;FORM IN EAX the rand
			mov EBX, EAX
			ror EBX, 7
			mov EAX, EBX
			
			
			;FORM in ECX THE FINAL VALUE OF THE SEED
			mul EAX ;We take only the value of the lower part
			add EAX, k
					
		
			;PRINTING PROCEDURE
			push 	DWORD EAX
			push    DWORD text 
			call    _printf
			add     esp, 8
			push    0
			
	JMP repeta
	
	final:
        call    _exit
        ret 

section .data

text:   dd      'Your random number is: %d',0 
k: 	dd 1357