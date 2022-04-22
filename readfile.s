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
	
; -------------------------------------------------------

; Variables/constants for main.
	BUFF_SIZE equ 1000
	newLine db LF, NULL
	db LF, LF, NULL
	fileDesc dq 0
	errMsgOpen db "Error opening the file.", LF, NULL
	errMsgRead db "Error reading from the file.", LF, NULL
	
; -------------------------------------------------------

section .bss
	readBuffer resb BUFF_SIZE

; -------------------------------------------------------

    extern printString

; -------------------------------------------------------
section .text

global readfile
readfile:
    mov rax, SYS_open ; file open
    mov rdi, qword[r13+8] ; file name string
    mov rsi, O_RDONLY ; read only access
    syscall ; call the kernel
    cmp rax, 0 ; check for success
    jl errorOnOpen
    mov qword [fileDesc], rax ; save descriptor
    ; -----
; Read from file.
; For this example, we know that the file has only 1 line.
; System Service - Read
; rax = SYS_read
; rdi = file descriptor
; rsi = address of where to place data
; rdx = count of characters to read
; Returns:
; if error -> rax < 0
; if success -> rax = count of characters actually read
    mov rax, SYS_read
    mov rdi, qword [fileDesc]
    mov rsi, readBuffer
    mov rdx, BUFF_SIZE
    syscall
    cmp rax, 0
    jl errorOnRead
    mov rdi, readBuffer
    mov r8, rdi
; Close the file.
; System Service - close
; rax = SYS_close
; rdi = file descriptor
    mov rax, SYS_close
    mov rdi, qword [fileDesc]
    syscall
    mov rdi, r8
    ret
; -----
; Error on open.
; note, eax contains an error code which is not used
; for this example.
errorOnOpen:
    mov rdi, errMsgOpen
    call printString
    jmp Done
; -----
; Error on read.
; note, eax contains an error code which is not used
; for this example.
errorOnRead:
    mov rdi, errMsgRead
    call printString
    jmp Done
Done:
    mov rax, SYS_exit
    mov rdi, EXIT_SUCCESS
    syscall



