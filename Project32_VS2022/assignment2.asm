; Exercise 2 - Copy a string in reverse order

INCLUDE Irvine32.inc
.data
    source BYTE "This is the source string", 0   ; Source string with null end
    target BYTE SIZEOF source DUP('#')            ; Target array fill with '#'

.code
main PROC
    mov esi, OFFSET source                       ; Put source address in ESI
    mov edi, OFFSET target                       ; Put target address in EDI

    mov ecx, SIZEOF source - 2                   ; ECX is length of source - 2
    add esi, ecx                                ; Move ESI to end of source string

    mov ecx, SIZEOF source - 1                   ; ECX is counter for loop, length - 1

reverse_copy_loop:
    mov al, [esi]                                ; Take char from source into AL
    mov [edi], al                                ; Put char in target
    dec esi                                      ; Move ESI to char before
    inc edi                                      ; Move EDI to next spot
    loop reverse_copy_loop                       ; Do again until ECX zero

    mov byte ptr [edi], 0                        ; Put null at end of target

    mov edx, OFFSET source                       ; Put source address in EDX
    call WriteString                             ; Show source string
    call Crlf                                    ; New line
    mov edx, OFFSET target                       ; Put target address in EDX
    call WriteString                             ; Show target string

    exit                                         ; End program
main ENDP

END main
