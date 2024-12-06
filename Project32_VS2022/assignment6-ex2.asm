; Program Name: RANDOM STRINGS
; Course: CIS21JA Assembly Language
; Author: Inky Ganbold
; Date: Dec 5, 2024

INCLUDE Irvine32.inc
.data
    buffer BYTE 26 DUP(?), 0 ; Array to hold random string
    numStrings DWORD 20      ; Number of random strings to generate
    stringLength DWORD 10    ; Length of each random string
.code
RandomString PROC
    ; Input: EAX = length, EBX = address of buffer
    push ecx
    mov ecx, eax
L1:
    mov eax, 26               ; Range for random numbers (A-Z)
    call RandomRange
    add al, 65                ; Convert to ASCII A-Z
    mov [ebx], al             ; Store in buffer
    inc ebx
    loop L1
    mov byte ptr [ebx], 0     ; Null-terminate the string
    pop ecx
    ret
RandomString ENDP

main PROC
    call Randomize            ; Seed random number generator

    mov ecx, numStrings       ; Loop for the number of strings
L2:
    mov eax, stringLength     ; Length of each string
    mov ebx, OFFSET buffer    ; Address of the buffer
    call RandomString         ; Generate random string

    mov edx, OFFSET buffer    ; Display the string
    call WriteString
    call Crlf                 ; New line after each string
    loop L2

    exit
main ENDP
END main
