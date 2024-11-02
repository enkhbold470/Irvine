; Assignment #1 Problem 1
; Author: Enkhbold Ganbold (Inky)
; Date: October 23, 2024
; Description: Converts binary strings to decimal and displays results with descriptive text

.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword
include Irvine32.inc
includelib Irvine32.lib

.data
    binaryStr1 db '1010', 0                   ; Small binary example (decimal 10)
    binaryStr2 db '110101010101010', 0         ; Middle binary example (decimal 3410)
    binaryStr3 db '1111111111111111', 0        ; Full 16-bit binary example (decimal 65535)
    
    msgBinary1 BYTE "Binary 1010 (decimal 10): ", 0
    msgBinary2 BYTE "Binary 110101010101010 (decimal 3410): ", 0
    msgBinary3 BYTE "Binary 1111111111111111 (decimal 65535): ", 0
    
    resultBinary dd ?

.code
main proc
    ; Process the first binary string
    mov edx, OFFSET msgBinary1
    call WriteString
    lea eax, binaryStr1
    call BinaryToInt
    mov resultBinary, eax
    call WriteResult

    ; Process the second binary string
    mov edx, OFFSET msgBinary2
    call WriteString
    lea eax, binaryStr2
    call BinaryToInt
    mov resultBinary, eax
    call WriteResult

    ; Process the third binary string
    mov edx, OFFSET msgBinary3
    call WriteString
    lea eax, binaryStr3
    call BinaryToInt
    mov resultBinary, eax
    call WriteResult

    invoke ExitProcess, 0
main endp

BinaryToInt proc
    push ebx
    push ecx
    push edx
    xor ebx, ebx                   ; ebx will store the result
    xor ecx, ecx                   ; ecx is the index
    mov edx, eax                   ; Load the address of the binary string

BinaryLoop:
    mov al, byte ptr [edx + ecx]
    cmp al, 0
    je EndBinaryLoop               ; Exit when null terminator is found
    shl ebx, 1                     ; Multiply the result by 2 (shift left 1 bit)
    cmp al, '0'
    je SkipAddition                ; If '0', skip addition
    cmp al, '1'
    je AddOne                      ; If '1', add to result

SkipAddition:
    inc ecx                        ; Move to the next character
    jmp BinaryLoop

AddOne:
    inc ebx                        ; Increment result for '1'
    jmp SkipAddition

EndBinaryLoop:
    mov eax, ebx                   ; Move result into eax
    pop edx
    pop ecx
    pop ebx
    ret
BinaryToInt endp

WriteResult proc
    mov eax, resultBinary          ; Load result into eax
    call WriteDec                  ; Display the result as decimal
    call Crlf                      ; Print a new line
    ret
WriteResult endp

; Assignment #1 Problem 2
; Description: Converts hexadecimal strings to decimal and displays results with descriptive text

.data
    hexStr1 db 'A', 0                       ; Small hex example (decimal 10)
    hexStr2 db '1F4A', 0                    ; Middle hex example (decimal 8010)
    hexStr3 db 'FFFFFFFF', 0                ; Full 32-bit hex example (decimal 4294967295)
    
    msgHex1 BYTE "Hexadecimal A (decimal 10): ", 0
    msgHex2 BYTE "Hexadecimal 1F4A (decimal 8010): ", 0
    msgHex3 BYTE "Hexadecimal FFFFFFFF (decimal 4294967295): ", 0
    
    resultHex dd ?

main proc
    ; Process the first hex string
    mov edx, OFFSET msgHex1
    call WriteString
    lea eax, hexStr1
    call HexToInt
    mov resultHex, eax
    call WriteResult

    ; Process the second hex string
    mov edx, OFFSET msgHex2
    call WriteString
    lea eax, hexStr2
    call HexToInt
    mov resultHex, eax
    call WriteResult

    ; Process the third hex string
    mov edx, OFFSET msgHex3
    call WriteString
    lea eax, hexStr3
    call HexToInt
    mov resultHex, eax
    call WriteResult

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
    jb SkipAddition                ; Skip if less than '0'
    cmp al, '9'
    jbe AddNumeric                 ; If between '0' and '9', add numeric value
    cmp al, 'A'
    jb SkipAddition                ; Skip if less than 'A'
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
    mov eax, ebx                   ; Move result into eax
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
