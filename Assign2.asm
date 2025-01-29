%macro io 4
	mov rax,%1
	mov rdi,%2
	mov rsi,%3
	mov rdx,%4
	syscall

%endmacro


section .data
	length db 0
	msg1 db" Enter the string:",10
	msg1len equ $-msg1
	msg2 db"Length of entered string without loop is:",10
	msg2len equ $-msg2
	msg3 db "Length of entered string with loop is:",10
	msg3len equ $-msg3
	newline db 10

section .bss
	string1 resb 30
	ascii_num resb 2

section .code
	global _start
	_start:
		io 1,1,msg1,msg1len
		io 0,0,string1,30
		dec rax
		mov rbx,rax
		io 1,1,msg2,msg2len
		call hex_ascii8
		mov rsi,string1

	back:
		
		mov al, [rsi]
		cmp al,10
		je skip
		inc byte[length]
		inc rsi
		loop back

	skip:
		mov bl,[length]
		io 1,1,msg3,msg3len
		call hex_ascii8

mov rax,60
mov rdi,1
syscall

hex_ascii8:
	mov rdi,ascii_num
	mov rcx,2
        lbl:
		rol bl,4
		mov al,bl
		and al,0fh
		cmp al,9
		jbe add30h
		add al,7H                        
		add30h:
			add al,30H
		mov[rdi],al
		inc rdi
		dec rcx
		jnz lbl
		io 1,1,ascii_num,2
		io 1,1,newline,1
	ret
	

