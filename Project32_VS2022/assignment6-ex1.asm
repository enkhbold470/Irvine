; Program Name: SIMPLE ADDITION
; Course: CIS21JA Assembly Language
; Author: Inky Ganbold
; Date: Dec 5, 2024

INCLUDE Irvine32.inc
.data
    prompt1 BYTE "Enter first integer: ", 0
    prompt2 BYTE "Enter second integer: ", 0
    resultMsg BYTE "The sum is: ", 0
.code
main PROC
    call Clrscr              ; Clear the screen

    mov edx, OFFSET prompt1  ; Prompt for the first integer
    call WriteString
    call ReadInt             ; Read the first integer
    mov ebx, eax             ; Store the first integer in EBX

    mov edx, OFFSET prompt2  ; Prompt for the second integer
    call WriteString
    call ReadInt             ; Read the second integer
    add eax, ebx             ; Add the two integers (result in EAX)

    mov edx, OFFSET resultMsg ; Print the result message
    call WriteString
    call WriteInt            ; Display the sum

    exit
main ENDP
END main
