; Assignment #1 Problem 1
.386
.model flat, stdcall            ; Specify the memory model and calling convention
.stack 4096
ExitProcess proto, dwExitCode:dword
include Irvine32.inc
includelib Irvine32.lib

.data
binaryStr1 db '1010', 0           ; Small binary example (decimal 10)
binaryStr2 db '110101010101010', 0 ; Middle binary example (decimal 3410)
binaryStr3 db '1111111111111111', 0 ; Full 16-bit binary (decimal 65535)
resultBinary dd ?

labelStr1 db "Result for binaryStr1 (1010): ", 0
labelStr2 db "Result for binaryStr2 (110101010101010): ", 0
labelStr3 db "Result for binaryStr3 (1111111111111111): ", 0

.code
main proc
    ; Process the first binary string
    lea eax, binaryStr1
    call BinaryToInt
    mov resultBinary, eax
    lea edx, labelStr1
    call WriteString
    call WriteResult

    ; Process the second binary string
    lea eax, binaryStr2
    call BinaryToInt
    mov resultBinary, eax
    lea edx, labelStr2
    call WriteString
    call WriteResult

    ; Process the third binary string
    lea eax, binaryStr3
    call BinaryToInt
    mov resultBinary, eax
    lea edx, labelStr3
    call WriteString
    call WriteResult

    invoke ExitProcess, 0
main endp

BinaryToInt proc
    push ebx
    push ecx
    push edx
    xor ebx, ebx
    xor ecx, ecx
    mov edx, eax

BinaryLoop:
    mov al, byte ptr [edx + ecx]
    cmp al, 0
    je EndBinaryLoop
    shl ebx, 1
    cmp al, '0'
    je SkipAddition
    cmp al, '1'
    je AddOne

SkipAddition:
    inc ecx
    jmp BinaryLoop

AddOne:
    inc ebx
    jmp SkipAddition

EndBinaryLoop:
    mov eax, ebx
    pop edx
    pop ecx
    pop ebx
    ret
BinaryToInt endp

WriteResult proc
    mov eax, resultBinary
    call WriteDec
    call Crlf
    ret
WriteResult endp

end main
