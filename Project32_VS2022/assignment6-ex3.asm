; Program Name: Color Matrix
; Course: CIS21JA Assembly Language
; Author: Inky Ganbold
; Date: Dec 5, 2024

    INCLUDE Irvine32.inc
    .data
        char BYTE 'X', 0         ; Character to display
    .code
    main PROC
        mov ecx, 16              ; Loop for background colors (16 rows)
    OuterLoop:
        push ecx
        mov ecx, 16              ; Loop for foreground colors (16 columns)
    InnerLoop:
        push ecx
        mov eax, ecx             ; Foreground color
        mov ebx, ecx             ; Background color
        shl ebx, 4               ; Shift background to higher nibble
        add eax, ebx             ; Combine foreground and background
        call SetTextColor        ; Set the text color
        mov edx, OFFSET char     ; Point to character "X"
        call WriteString         ; Print the character
        pop ecx
        loop InnerLoop
        call Crlf                ; Move to the next line
        pop ecx
        loop OuterLoop
        exit
    main ENDP
    END main


