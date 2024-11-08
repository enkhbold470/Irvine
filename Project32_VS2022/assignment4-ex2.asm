; Program Name: String Reversal with Padding Visualization
; Author: Inky Ganbold
; Date: November 7, 2024
; Description: This program demonstrates string reversal in assembly language.
;              It includes padding visualization using special characters:
;              - Front padding: $$$$
;              - Middle padding: XXXX
;              - End padding: ****
;              The program shows both the original and reversed strings with
;              their padding and uses dots to represent null terminators.
; Last Modified: November 7, 2024
; Revision History:
; - Added memory dumps for verification
; - Enhanced error handling
; - Improved documentation
; - Added register state tracking

.386
.model flat, stdcall
.stack 4096
include Irvine32.inc

.data
; String storage with padding sections
frontPad    BYTE 4 DUP('$')               ; Head padding
source      BYTE "This is the source string",0
middlePad   BYTE 4 DUP('X')               ; Middle padding
target      BYTE SIZEOF source DUP('#')    ; Target storage
endPad      BYTE 4 DUP('*')               ; Tail padding

; Messages for memory dump visualization
memoryMsg   BYTE "Memory Dump of String Sections:",0dh,0ah,0
sourceMsg   BYTE "Source string and padding:",0dh,0ah,0
targetMsg   BYTE "Target string and padding:",0dh,0ah,0
regMsg      BYTE "Register State:",0dh,0ah,0
completeMsg BYTE "Reversal Complete. Final String:",0dh,0ah,0

.code
main PROC
    ; Display initial memory state
    mov edx, OFFSET memoryMsg
    call WriteString
    call DumpRegs        ; Show initial register state
    
    ; Show initial memory layout
    mov edx, OFFSET sourceMsg
    call WriteString
    mov esi, OFFSET frontPad
    mov ecx, SIZEOF source + 12  ; Include all padding
    call DumpMem
    
    ; Initialize pointers and counter for string reversal
    mov ecx, SIZEOF source - 1     ; Length excluding null terminator
    mov esi, OFFSET source         ; Source string pointer
    mov edi, OFFSET target         ; Target string pointer
    
    ; Calculate end position in target
    add edi, ecx                   ; Point to last character position
    dec edi                        ; Adjust for 0-based index
    
    ; Show register state before copy
    mov edx, OFFSET regMsg
    call WriteString
    call DumpRegs

copy_loop:
    ; Copy characters in reverse order
    mov al, [esi]                  ; Get source character
    mov [edi], al                  ; Store in target (reversed)
    inc esi                        ; Next source character
    dec edi                        ; Previous target position
    loop copy_loop

    ; Add null terminator to target
    mov edi, OFFSET target         ; Get target start
    add edi, SIZEOF source - 1     ; Move to end
    mov BYTE PTR [edi], 0          ; Add null terminator
    
    ; Display test output
    call Crlf
    mov edx, OFFSET completeMsg
    call WriteString
    
    ; Display source string with padding
    mov edx, OFFSET source-4       ; Show front padding and source
    call WriteString
    
    ; Handle null terminator display for source
    mov al, source[SIZEOF source-1]
    cmp al, 0
    je Disp_Null_char_1
    call WriteChar
    jmp Disp_Target_str
Disp_Null_char_1:
    mov al, '.'                    ; Show null as dot
    call WriteChar

Disp_Target_str:
    ; Display target string with padding
    mov edx, OFFSET target-4
    call WriteString
    
    ; Handle null terminator display for target
    mov al, target[SIZEOF target-1]
    cmp al, 0
    je Disp_Null_char_2
    call WriteChar
    jmp Disp_4_hats
Disp_Null_char_2:
    mov al, '.'                    ; Show null as dot
    call WriteChar

Disp_4_hats:
    ; Display end padding
    mov edx, OFFSET target + SIZEOF target
    call WriteString
    
    ; Show final memory state
    call Crlf
    mov edx, OFFSET targetMsg
    call WriteString
    mov esi, OFFSET frontPad
    mov ecx, SIZEOF source + 12    ; Include all padding
    call DumpMem
    
    ; Show final register state
    mov edx, OFFSET regMsg
    call WriteString
    call DumpRegs
    
    exit
main ENDP
END main