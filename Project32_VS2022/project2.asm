.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

include Irvine32.inc
includelib Irvine32.lib

.data
hexStr1 db 'A', 0               ; Small hex example (decimal 10)
hexStr2 db '1F4A', 0            ; Middle hex example (decimal 8010)
hexStr3 db 'FFFFFFFF', 0         ; Full 32-bit hex string example (decimal 4294967295)
resultHex dd ?

; Labels for output
labelHexStr1 db "Result for hexStr1 ('A'): ", 0
labelHexStr2 db "Result for hexStr2 ('1F4A'): ", 0
labelHexStr3 db "Result for hexStr3 ('FFFFFFFF'): ", 0

.code
main proc
    ; Process the first hex string
    lea eax, hexStr1
    call HexToInt
    mov resultHex, eax             ; Store the result in memory
    lea edx, labelHexStr1          ; Load the label for the first hex string
    call WriteString
    call WriteResult                ; Display the result

    ; Process the second hex string
    lea eax, hexStr2
    call HexToInt
    mov resultHex, eax
    lea edx, labelHexStr2          ; Load the label for the second hex string
    call WriteString
    call WriteResult                ; Display the result

    ; Process the third hex string
    lea eax, hexStr3
    call HexToInt
    mov resultHex, eax
    lea edx, labelHexStr3          ; Load the label for the third hex string
    call WriteString
    call WriteResult                ; Display the result

    invoke ExitProcess, 0
main endp

HexToInt proc
    push ebx
    push ecx
    push edx
    xor ebx, ebx                   ; ebx will store the result
    xor ecx, ecx                   ; ecx is the index
    mov edx, eax                   ; Load the address of the hex string

HexLoop:
    mov al, byte ptr [edx + ecx]
    cmp al, 0
    je EndHexLoop                  ; Exit when null terminator is found
    shl ebx, 4                     ; Multiply the result by 16 (shift left 4 bits)

    cmp al, '0'
    jb SkipAddition                ; If less than '0', skip (invalid)
    cmp al, '9'
    jbe AddNumeric                 ; If between '0' and '9', add numeric value
    cmp al, 'A'
    jb SkipAddition                ; If less than 'A', skip
    cmp al, 'F'
    jbe AddAlpha                   ; If between 'A' and 'F', add alpha value
    jmp SkipAddition

AddNumeric:
    sub al, '0'
    jmp AddToResult

AddAlpha:
    sub al, 'A'
    add al, 10

AddToResult:
    add ebx, eax

SkipAddition:
    inc ecx                        ; Move to the next character
    jmp HexLoop

EndHexLoop:
    mov eax, ebx                   ; Move the result into eax
    pop edx
    pop ecx
    pop ebx
    ret
HexToInt endp

WriteResult proc
    mov eax, resultHex             ; Load result into eax
    call WriteDec                  ; Display the result as decimal
    call Crlf                      ; Print a new line
    ret
WriteResult endp

end main
