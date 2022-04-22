;####################################################################
;Author : 
;   633040166-1 Palapon Soontornpas
;   633040151-4 Jirathon Chaisuk
;
;####################################################################

section .data
	LF equ 10 ; line feed
	NULL equ 0 ; end of string
	TRUE equ 1
	FALSE equ 0
	EXIT_SUCCESS equ 0 ; success code
	STDIN equ 0 ; standard input
	STDOUT equ 1 ; standard output
	STDERR equ 2 ; standard error
	SYS_read equ 0 ; read
	SYS_write equ 1 ; write
	SYS_open equ 2 ; file open
	SYS_close equ 3 ; file close
	SYS_fork equ 57 ; fork
	SYS_exit equ 60 ; terminate
	SYS_creat equ 85 ; file open/create
	SYS_time equ 201 ; get time
	O_CREAT equ 0x40
	O_TRUNC equ 0x200
	O_APPEND equ 0x400
	O_RDONLY equ 000000q ; read only
	O_WRONLY equ 000001q ; write only
	O_RDWR equ 000002q ; read and write
	S_IRUSR equ 00400q
	S_IWUSR equ 00200q
	S_IXUSR equ 00100q
	newLine db LF, NULL
; -------------------------------------------------------

section .text
; **********************************************************
; Generic procedure to display a string to the screen.
; String must be NULL terminated.
; Algorithm:
; Count characters in string (excluding NULL)
; Use syscall to output characters
; Arguments:
; 1) address, string
; Returns:
; nothing
extern getLength
global printString
printString:
	push rbp
	mov rbp, rsp
	push rbx
	;currently, we got rdi as 1st argument, that continue sending to getLength function.
	call getLength
	mov rdx, rax ; rax will be length, move to rdx for length of print string.
	mov rax, SYS_write ; code for write()
	mov rsi, rdi ; addr of characters
	mov rdi, STDOUT ; file descriptor
	syscall
	; String printed, return to calling routine.
	pop rbx
	pop rbp
	ret
