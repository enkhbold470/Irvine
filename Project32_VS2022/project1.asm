.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

include Irvine32.inc
includelib Irvine32.lib

.data
binaryStr1 db '1010', 0           ; Small binary example (decimal 10)
binaryStr2 db '110101010101010', 0 ; Middle binary example (decimal 3410)
binaryStr3 db '1111111111111111', 0 ; Full 16-bit binary (decimal 65535)
resultBinary dd ?

.code
main proc
    ; Process the first binary string
    lea eax, binaryStr1
    call BinaryToInt
    mov resultBinary, eax          ; Store the result in memory
    call WriteResult                ; Display the result

    ; Process the second binary string
    lea eax, binaryStr2
    call BinaryToInt
    mov resultBinary, eax
    call WriteResult                ; Display the result

    ; Process the third binary string
    lea eax, binaryStr3
    call BinaryToInt
    mov resultBinary, eax
    call WriteResult                ; Display the result

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
    je SkipAddition                ; If it's '0', just skip addition
    cmp al, '1'
    je AddOne                      ; If it's '1', add to the result

SkipAddition:
    inc ecx                        ; Move to the next character
    jmp BinaryLoop

AddOne:
    inc ebx                        ; Increment the result for '1'
    jmp SkipAddition

EndBinaryLoop:
    mov eax, ebx                   ; Move the result into eax
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

end main
