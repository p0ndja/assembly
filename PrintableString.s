;####################################################################
;Author : 
;   633040166-1 Palapon Soontornpas
;   633040151-4 Jirathon Chaisuk
;
;####################################################################

;Get BIG string and return only printable string

global getPrintableString
getPrintableString:
    ; rdi -> 1st arg, variable for input string
    ; rsi -> 2nd arg, variable for output string
    push rdx            ; Temporary char
    mov rdx, 0

checkPrtStr:
    mov al, byte[rdi]   ; al = rdi (Current Char)
    
    cmp al, 0           ; Compare each char to "\0" (End of String)
    je endPrintableString        ; rax = 0 jump to endPrtStr (Finish Function)

    ;Accept only char between 32 - 126 (ASCII) (As-in-spec)
    cmp al, 32          ; Compare al to 32
    jl continuePrtStr   ; If al < 32,  skip adding that char to result by jump to continuePrtStr
    cmp al, 126         ; Compare al to 126
    jg continuePrtStr   ; If al > 126, skip adding that char to result by jump to continuePrtStr

    ;Else, char in range of 32 - 126
    mov byte[rsi], al   ; Add this char into result (rsi)
    inc rsi             ; rsi++, make next char able to be place next to it

continuePrtStr:
    inc rdi             ; rdi++, to check the next char
    jmp checkPrtStr     ; Jump back to checkPrtStr

endPrintableString:
    mov byte[rsi], 0    ; Add "\0" (End of String) to rsi
    pop rdx             ;
    mov rdi, rdx
    ret                 ; Return, rdx will be the printable string

