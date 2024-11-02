; Integer Expression Calculator
; Calculates A = (A + B) - (C + D)
; Author: Enkhbold Ganbold (Inky)
; Date: October 23, 2024
; Description: This program demonstrates arithmetic operations in assembly
;             by calculating (A + B) - (C + D) and displaying the result

INCLUDE Irvine32.inc

.data
    msgResult BYTE "The result of (A + B) - (C + D) is: ", 0
    
.code
main PROC
    ; Initialize the registers with test values
    mov    eax, 100    ; A = 100
    mov    ebx, 50     ; B = 50
    mov    ecx, 30     ; C = 30
    mov    edx, 20     ; D = 20

    ; Save original EAX value as we'll need it for display later
    push   eax
    
    ; Calculate (A + B)
    add    eax, ebx    ; EAX now contains (A + B)
    
    ; Calculate (C + D)
    mov    ebx, ecx    ; Move C to EBX
    add    ebx, edx    ; EBX now contains (C + D)
    


    ; Calculate final result: (A + B) - (C + D)
    sub    eax, ebx    ; EAX now contains final result
    
    ; Display the result string
    mov    edx, OFFSET msgResult
    call   WriteString
    

    ; Display the numeric result
    call   WriteInt
    
    ; Add a newline for clean output
    call   Crlf
    
    ; Restore original EAX value
    pop    eax
    
    exit
main ENDP
END main