; Program Name: Array Sum within Specified Range
; Description: Calculates sum of array elements within a given range
; Course: CIS21JA Assembly Language
; Author: Inky Ganbold
; Date: Nov 26, 2024
; Procedures:
;   - main: Primary program logic for array sum calculation
;   - Demonstrates bitwise operations and range-based summation

INCLUDE Irvine32.inc

.data
    ; Test Arrays with Varied Data Types
    array_1 SDWORD 10, 30, 25, 15, 17, 19, 40, 41, 43       ; Positive numbers
    array_2 SDWORD 10, -30, 25, 15, -17, 55, 40, 41, 43     ; Mixed positive/negative
    
    ; Range Limits for Summation
    lowerLimit SDWORD 20     ; Lower boundary of range
    upperLimit SDWORD 40     ; Upper boundary of range
    
    ; Debugging Messages
    msg1 BYTE "Sum of Array 1: ", 0
    msg2 BYTE "Sum of Array 2: ", 0

.code
main PROC
    ; Procedure to calculate sum of array elements within specified range
    ; Input: 
    ;   - array_1/array_2: Source arrays
    ;   - lowerLimit, upperLimit: Range boundaries
    ; Output: 
    ;   - EAX: Sum of elements within range

    ; Array 1 Processing
    mov esi, OFFSET array_1      ; Load array's memory address
    mov ecx, LENGTHOF array_1    ; Set loop counter to array length
    mov eax, 0                   ; Initialize sum to zero

    ; Iterate through first array
L1_SumRange:
    mov ebx, [esi]               ; Load current array element
    cmp ebx, lowerLimit           ; Compare with lower boundary
    jl L1_Skip                    ; Skip if below lower limit
    cmp ebx, upperLimit           ; Compare with upper boundary
    jg L1_Skip                    ; Skip if above upper limit
    add eax, ebx                  ; Add to sum if within range

L1_Skip:
    add esi, TYPE array_1         ; Move to next array element
    loop L1_SumRange              ; Continue until all elements processed

    ; Display Array 1 Sum Results
    mov edx, OFFSET msg1          ; Load message address
    call WriteString              ; Display message
    call WriteInt                 ; Display sum in EAX
    call Crlf                     ; New line

    ; Reset for Array 2
    mov esi, OFFSET array_2       ; Load second array's address
    mov ecx, LENGTHOF array_2     ; Set loop counter
    mov eax, 0                    ; Reset sum to zero

    ; Iterate through second array
L2_SumRange:
    mov ebx, [esi]                ; Load current array element
    cmp ebx, lowerLimit           ; Compare with lower boundary
    jl L2_Skip                    ; Skip if below lower limit
    cmp ebx, upperLimit           ; Compare with upper boundary
    jg L2_Skip                    ; Skip if above upper limit
    add eax, ebx                  ; Add to sum if within range

L2_Skip:
    add esi, TYPE array_2         ; Move to next array element
    loop L2_SumRange              ; Continue until all elements processed

    ; Display Array 2 Sum Results
    mov edx, OFFSET msg2          ; Load message address
    call WriteString              ; Display message
    call WriteInt                 ; Display sum in EAX
    call Crlf                     ; New line

    ; Final debugging - register dump
    call DumpRegs                 ; Show register contents

    exit
main ENDP

END main