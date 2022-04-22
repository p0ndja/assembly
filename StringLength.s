;####################################################################
;Author : 
;   633040166-1 Palapon Soontornpas
;   633040151-4 Jirathon Chaisuk
;
;####################################################################

;Calculate LENGTH of string

global getLength
getLength:
    mov rax, rdi        ; rdi -> 1st arg, variable for input string
lengthLoop:
    cmp byte[rax], 0    ; Compare each char to "\0" (End of String)
    je endLength        ; rax = 0 jump to endLength (Finish Function)
    inc rax             ; rax++, to check the next char
    jmp lengthLoop      ; jump to the next char (Loop back to lengthLoop)
endLength:
    sub rax, rdi        ; Last Char Position - 1st Char Position
    ret                 ; Return, rax will be the length of string
