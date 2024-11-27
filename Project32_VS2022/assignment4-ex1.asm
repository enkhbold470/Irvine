; Program Name: Big to Little Endian Converter
; Author: Inky Ganbold
; Date: November 7, 2024
; Description: This program demonstrates endian conversion by taking a 32-bit value stored
;              in big-endian format and converting it to little-endian format. The program
;              uses the Irvine32 library for output and debugging functions to display
;              memory contents before and after conversion.
; Last Modified: November 7, 2024
; Revision History:
; - Added comprehensive memory dumps
; - Enhanced documentation
; - Added register state visualization
; - Improved error handling

.386
.model flat, stdcall
.stack 4096
include Irvine32.inc

.data
; Original big endian value stored as individual bytes
bigEndian    BYTE 12h, 34h, 56h, 78h    ; In memory: 12 34 56 78
littleEndian DWORD ?                     ; Will store: 78 56 34 12

; Messages for output clarity
titleMsg    BYTE "Endian Conversion Demonstration Program", 0dh, 0ah, 0
bigMsg      BYTE "DumpMem output showing Big Endian Byte Order:", 0dh, 0ah
            BYTE "Dump of offset ", 0
littleMsg   BYTE 0dh, 0ah, "DumpMem output showing Little Endian Byte Order:", 0dh, 0ah
            BYTE "Dump of offset ", 0
regStateMsg BYTE 0dh, 0ah, "Register States During Conversion:", 0dh, 0ah, 0

.code
main PROC
    ; Display program title
    mov edx, OFFSET titleMsg
    call WriteString
    call Crlf

    ; Display initial register states
    mov edx, OFFSET regStateMsg
    call WriteString
    call DumpRegs            ; Show initial register states

    ; Display original big endian byte order
    mov edx, OFFSET bigMsg
    call WriteString
    mov esi, OFFSET bigEndian
    mov ecx, TYPE DWORD
    call DumpMem            ; Show memory contents before conversion

    ; Convert from big endian to little endian
    ; Step 1: Load bytes in reverse order
    mov esi, OFFSET bigEndian
    movzx eax, BYTE PTR [esi+3]    ; Get last byte (78h) with zero extension
    movzx ebx, BYTE PTR [esi+2]    ; Get third byte (56h)
    movzx ecx, BYTE PTR [esi+1]    ; Get second byte (34h)
    movzx edx, BYTE PTR [esi]      ; Get first byte (12h)

    ; Show register states after loading bytes
    call DumpRegs

    ; Step 2: Store bytes in little endian order
    mov esi, OFFSET littleEndian
    mov [esi], al              ; Store 78h as first byte
    mov [esi+1], bl            ; Store 56h as second byte
    mov [esi+2], cl            ; Store 34h as third byte
    mov [esi+3], dl            ; Store 12h as last byte

    ; Display resulting little endian byte order
    mov edx, OFFSET littleMsg
    call WriteString
    mov esi, OFFSET littleEndian
    mov ecx, TYPE DWORD
    call DumpMem            ; Show memory contents after conversion

    ; Final register state display
    call Crlf
    mov edx, OFFSET regStateMsg
    call WriteString
    call DumpRegs            ; Show final register states

    exit
main ENDP

END main