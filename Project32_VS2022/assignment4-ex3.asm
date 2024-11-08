; Program Name: Array Right Rotation
; Author: Inky Ganbold
; Date: November 7, 2024
; Description: This program demonstrates array rotation in assembly language.
;              It performs a right rotation on a DWORD array, moving the last
;              element to the first position while shifting all other elements
;              right by one position.

.386
.model flat, stdcall
.stack 4096
include Irvine32.inc

.data
; Test array and related constants
array    DWORD 10h, 20h, 30h, 40h     ; Original array values
arraySize = ($ - array) / TYPE array   ; Calculate number of elements
tempVal  DWORD ?                       ; Temporary storage for rotation

; Output messages
titleMsg   BYTE "Array Right Rotation Demonstration", 0dh, 0ah, 0
beforeMsg  BYTE "Before rotation: ", 0
afterMsg   BYTE "After rotation:  ", 0
memoryMsg  BYTE "Memory Dump of Array:", 0dh, 0ah, 0
regMsg     BYTE "Register State:", 0dh, 0ah, 0
errorMsg   BYTE "Error: Array operation failed", 0dh, 0ah, 0

.code
main PROC
    ; Display program title
    mov edx, OFFSET titleMsg
    call WriteString
    call Crlf

    ; Show initial memory state
    mov edx, OFFSET memoryMsg
    call WriteString
    mov esi, OFFSET array
    mov ecx, arraySize * TYPE array
    call DumpMem

    ; Display original array
    mov esi, OFFSET array
    mov ecx, arraySize
    call PrintOriginalArray

    ; Store last element
    mov esi, OFFSET array
    mov eax, arraySize
    dec eax                        ; Get index of last element
    mov ebx, TYPE array
    mul ebx                        ; Calculate offset to last element
    add esi, eax                  ; Point to last element
    mov eax, [esi]                ; Get last element
    mov tempVal, eax              ; Store it

    ; Show register state before shift
    call Crlf
    mov edx, OFFSET regMsg
    call WriteString
    call DumpRegs

    ; Shift elements right
    mov ecx, arraySize
    dec ecx                        ; One less iteration for shifting
    call ShiftElements            ; ESI is already pointing to last element

    ; Move stored value to first position
    mov esi, OFFSET array
    mov eax, tempVal
    mov [esi], eax

    ; Display rotated array
    mov esi, OFFSET array
    mov ecx, arraySize
    call PrintRotatedArray

    ; Show final memory state
    call Crlf
    mov edx, OFFSET memoryMsg
    call WriteString
    mov esi, OFFSET array
    mov ecx, arraySize * TYPE array
    call DumpMem

    exit
main ENDP

PrintOriginalArray PROC
    push ecx                      ; Save count
    push esi                      ; Save array pointer
    
    mov edx, OFFSET beforeMsg
    call WriteString
    
    pop esi                       ; Restore array pointer
    pop ecx                       ; Restore count
    
L1: mov eax, [esi]               ; Get current element
    call WriteHex                ; Display in hex
    mov al, ' '                  ; Space between numbers
    call WriteChar
    add esi, TYPE array          ; Point to next element
    loop L1
    
    call Crlf
    ret
PrintOriginalArray ENDP

PrintRotatedArray PROC
    push ecx                     ; Save count
    push esi                     ; Save array pointer
    
    mov edx, OFFSET afterMsg
    call WriteString
    
    pop esi                      ; Restore array pointer
    pop ecx                      ; Restore count
    
L1: mov eax, [esi]              ; Get current element
    call WriteHex               ; Display in hex
    mov al, ' '                 ; Space between numbers
    call WriteChar
    add esi, TYPE array         ; Point to next element
    loop L1
    
    call Crlf
    ret
PrintRotatedArray ENDP

ShiftElements PROC
    push ecx                    ; Save count
    push esi                    ; Save array pointer
    
L1: mov eax, [esi - TYPE array] ; Get previous element
    mov [esi], eax             ; Move to current position
    sub esi, TYPE array        ; Move backward in array
    loop L1
    
    pop esi                    ; Restore array pointer
    pop ecx                    ; Restore count
    ret
ShiftElements ENDP

END main