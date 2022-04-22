;####################################################################
;Author : 
;   633040166-1 Palapon Soontornpas
;   633040151-4 Jirathon Chaisuk
;
;####################################################################

global main
section .data
;  Define standard constants.
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
	SYS_fork equ 57 ; fork	SYS_exit equ 60 ; terminate
	SYS_creat equ 85 ; file open/create
	SYS_time equ 201 ; get time
	
; Variables for main.
	newLine db LF, NULL
; ------------------------------------------------------

section .bss
	inputChars 	resb 1000
	outputChars resb 1000

; ------------------------------------------------------

section .text

	extern readfile
	extern getPrintableString
	extern printString
	extern openandcreate
	extern getLength

main:
; -----
;  Get command line arguments and echo to screen.
;  Based on the standard calling convention,
; rdi = argc (argument count)
; rsi = argv (starting address of argument vector)
	mov r12, rdi ; save for later use...
	mov r13, rsi
start:
	call readfile 						;read an input file.
	mov rdi, r8 						;set argument for get printable string
	mov rsi, outputChars 				;set argument for get printable string
	call getPrintableString 			;get string that printable
	mov rdi, outputChars				;save output to rdi
	mov r9, rdi 						;save for later use...
	;call printString 					;for testing...
	printNewLine
	mov rdi, r9							;set variable to get length of string for write file.
	call getLength						;call fuction.
	mov r10, rax						;save length of string
	call openandcreate					;call function to write file openandcreate(r9<string>,r10<int>)
	jmp exit							;program done
exit:
	mov rax, 60
	mov rdi, 0
	syscall	
	
	



