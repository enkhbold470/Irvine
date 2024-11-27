; Program Name: Bitwise Multiplication without Multiplication Instruction
; Description: Implements multiplication using shifting and addition
; Course: CIS21JA Assembly Language
; Author: Inky Ganbold
; Date: Nov 26, 2024
; Procedures:
;   - BitwiseMultiply: Performs multiplication via bitwise operations
;   - Demonstrates alternative multiplication technique

INCLUDE Irvine32.inc

.data
    ; Test Case Labels for Debugging
    msg1 BYTE "Test Case 1 (65531 * 1029): ", 0
    msg2 BYTE "Test Case 2 (699050 * 5461): ", 0
    msg3 BYTE "Test Case 3 (21 * 178956970): ", 0

.code
BitwiseMultiply PROC
    ; Bitwise Multiplication Algorithm
    ; Input: 
    ;   - EBX: Multiplicand
    ;   - EAX: Multiplier
    ; Output:
    ;   - EAX: Product of multiplication

    push ecx                ; Preserve ECX for function
    push edx                ; Preserve EDX for function
    mov ecx, eax            ; Copy multiplier to ECX
    mov eax, 0              ; Initialize product to zero

    ; Iterative Multiplication Logic
BitMultLoop:
    test ecx, 1             ; Check least significant bit
    jz SkipAddition         ; Skip if bit is zero

    add eax, ebx            ; Add multiplicand to product
    
SkipAddition:
    shl ebx, 1              ; Left shift multiplicand (equivalent to *2)
    shr ecx, 1              ; Right shift multiplier (divide by 2)
    jnz BitMultLoop         ; Continue until multiplier becomes zero

    pop edx                 ; Restore EDX
    pop ecx                 ; Restore ECX
    ret                     ; Return with product in EAX
BitwiseMultiply ENDP

main PROC
    ; Test Case 1: Positive Numbers
    mov eax, 1029           ; Multiplier
    mov ebx, 65531          ; Multiplicand
    call BitwiseMultiply
    mov edx, OFFSET msg1    ; Load test case message
    call WriteString
    call WriteInt           ; Display result
    call Crlf

    ; Test Case 2: Large Numbers
    mov eax, 5461           ; Multiplier
    mov ebx, 699050         ; Multiplicand
    call BitwiseMultiply
    mov edx, OFFSET msg2    ; Load test case message
    call WriteString
    call WriteInt           ; Display result
    call Crlf

    ; Test Case 3: Mixed Size Numbers
    mov eax, 178956970      ; Large multiplier
    mov ebx, 21             ; Small multiplicand
    call BitwiseMultiply
    mov edx, OFFSET msg3    ; Load test case message
    call WriteString
    call WriteInt           ; Display result
    call Crlf

    ; Final debugging step
    call DumpRegs           ; Show register contents at end

    exit
main ENDP

END main