; Integer Expression Calculator
; Calculates A = (A + B) - (C + D)
; Author: Enkhbold Ganbold (Inky)
; Date: October 23, 2024
; Description: This program demonstrates arithmetic operations in assembly
;              by calculating (A + B) - (C + D) and displaying the result

INCLUDE Irvine32.inc

.data
    valA      DWORD 100
    valB      DWORD 50
    valC      DWORD 30
    valD      DWORD 20
    msgResult BYTE "The result of (A + B) - (C + D) is: ", 0
    msgA      BYTE "A = ", 0
    msgB      BYTE "B = ", 0
    msgC      BYTE "C = ", 0
    msgD      BYTE "D = ", 0
    
.code
main PROC
    ; Display initial values of A, B, C, and D
    mov    eax, valA
    mov    edx, OFFSET msgA
    call   WriteString
    call   WriteInt
    call   Crlf
    
    mov    eax, valB
    mov    edx, OFFSET msgB
    call   WriteString
    call   WriteInt
    call   Crlf
    
    mov    eax, valC
    mov    edx, OFFSET msgC
    call   WriteString
    call   WriteInt
    call   Crlf
    
    mov    eax, valD
    mov    edx, OFFSET msgD
    call   WriteString
    call   WriteInt
    call   Crlf

    ; Calculate (A + B)
    mov    eax, valA               ; Load A into EAX
    add    eax, valB               ; EAX now contains (A + B)
    
    ; Save (A + B) in EAX for final calculation
    push   eax
    
    ; Calculate (C + D)
    mov    ebx, valC               ; Load C into EBX
    add    ebx, valD               ; EBX now contains (C + D)
    
    ; Calculate final result: (A + B) - (C + D)
    pop    eax                     ; Restore (A + B) from the stack
    sub    eax, ebx                ; EAX now contains final result
    
    ; Display the result string
    mov    edx, OFFSET msgResult
    call   WriteString
    
    ; Display the numeric result
    call   WriteInt
    
    ; Add a newline for clean output
    call   Crlf
    
    exit
main ENDP
END main
