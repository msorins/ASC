[bits 32]
%include "msdn_defs.inc"

extern CreateFileA, ReadFile, WriteFile
extern SetFilePointer, CloseHandle
extern GetLastError

section .text 

extern  _printf
extern _exit

global  _main 

_main: 
		;CREATE FILE returneaza un HANDLE
		;CreateFile(fileName,
		;			GENERIC_READ | GENERIC_WRITE,
		;			0, 
		;			NULL, 
		;			OPEN_EXISTING,
		;			FILE_ATTRIBUTE_NORMAL,
		;			NULL
		;			)
		
		createFile:
			push dword NULL
			push dword FILE_ATTRIBUTE_NORMAL
			push dword OPEN_EXISTING
			push dword NULL
			push dword 0
			push dword GENERIC_READ|GENERIC_WRITE
			push dword fileName
			call CreateFileA
			
			cmp eax, INVALID_HANDLE_VALUE
			
			JE eroare
			;SAVE THE [HANDLE] value from EAX
			mov [handle], eax
		
	
		readFile:
			;BOOL ReadFile(
			;		handle ; !valoare
			;		buffer	; buffer TIMES 100 db 0, 0, adresa
			;		numberOfBytesToRead; valoare
			;		numberOfBytesRead; adresa
			;		null
			;		)
			
			push dword NULL
			push dword numberOfBytesRead
			push dword 100
			push dword buffer
			push dword [handle]
			call ReadFile
			
			cmp EAX, 0
			JE eroare
			
		
		writeFile:
			; BOOL WriteFile(
			;		handle ; valoare
			;		buffer ; adresa
			;		nrOfBytesToWrite; val
			;		nrOfBytesWritten; adresa
			;		NULL
			
			push dword NULL
			push dword numberOfBytesWritten
			push dword 100
			push dword bufferNew
			push dword [handle]
			call WriteFile
			
			CMP EAX, 0
			JE eroare
			
		closeFile:
			; CloseHandle ( handle; valoare )
			push dword [handle]
			call CloseHandle
			
		
		final:
		call    _exit
        ret

		eroare:
			call GetLastError
			push EAX
			push dword eroareMsg
			call _printf
			add     esp, 8
			push    0
			jmp final

section .data

eroareMsg:   db      'Eroare, ce facui? : %d',0 
scrieMsg: db 'Fisierul contine umratorul mesaj: %d', 0
fileName: db "05-text.txt", 0
handle: dd 0
numberOfBytesRead: dd 0
numberOfBytesWritten: dd 0
buffer TIMES 100 db 0, 0
bufferNew db 'blablabla', 0