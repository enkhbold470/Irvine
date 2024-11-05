; apply_Irvine_libs.asm - A simple test program calling various Irvine library procedures
; code base modified from demo program AddTwo.asm

; include the Irvine's library
INCLUDE Irvine32.inc

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
; strings(texts) for prompts
prompt_1st_int BYTE "Please enter the first integer: ",0
prompt_2nd_int BYTE "Please enter the second integer: ",0
prompt_text_color BYTE "Please pick the text color (1=blue, 2=green, 4=red, or any number from 0-15): ",0
prompt_proverb BYTE "Please teach me a proverb: ",0
response_str BYTE "The proverb I just learned: ", 0

; strings(texts) for output labels/descriptions
dec_sum_str BYTE "The sum in DEC is: ",0
hex_sum_str BYTE "The sum in HEX is: ",0
memory_dump_str BYTE "Memory Dump with operand_1, _2, and sum: ",0

; variables definitions
operand_1   SDWORD ?
operand_2   SDWORD ?
sum         SDWORD ?
color_code  DWORD ?
aString BYTE 80 DUP(0), 0

.code
main proc

   ;prompt the 1st number input
   mov  edx, OFFSET prompt_1st_int
   call WriteString
   
   ; set input text color, "yellow" is a pre-defined constant in the Irvine library
   mov eax, yellow
   call SetTextColor

   ; read input
   call ReadInt
   mov  operand_1, eax

   ; reset text color, "white" is a pre-define constant, in the Irvine library
   mov eax, white
   call SetTextColor

   ;prompt the 2nd number input
   mov  edx, OFFSET prompt_2nd_int
   call WriteString

   ; set input text color to yellow
   mov eax, yellow
   call SetTextColor

   ; read input
   call ReadInt
   mov  operand_2, eax
   call Crlf

   ; reset text color to white
   mov eax, white
   call SetTextColor

   ; prompt "output text color" selection
   mov  edx, OFFSET prompt_text_color
   call WriteString

   ; set input text color
   mov eax, yellow
   call SetTextColor

   ; read the color choice
   call ReadInt
   mov color_code, eax
   call Crlf

   ; reset text color to white
   mov eax, white
   call SetTextColor

   ; add the inputs, then save it to sum
   mov   eax, operand_1
   add   eax, operand_2

   ; save sum
   mov  sum, eax

   ; display sum in DEC
   mov  edx, OFFSET dec_sum_str
   call WriteString
   
   ; set text color
   mov eax, color_code
   call SetTextColor

   ; display sum
   mov eax, sum
   call WriteInt
   call Crlf

   ; reset text color to white
   mov eax, white
   call SetTextColor

   ; display sum in HEX
   mov  edx, OFFSET hex_sum_str
   call WriteString

   ; set text color
   mov eax, color_code
   call SetTextColor

   mov eax, sum
   call WriteHex
   call Crlf

   ; reset text color to white
   mov eax, white
   call SetTextColor

   ; display memory dump
   mov  edx, OFFSET memory_dump_str
   call WriteString

   ; set text color
   mov eax, color_code
   call SetTextColor

   ;dump the memories of operand_1, 2 and sum
   mov esi, OFFSET operand_1
   mov ecx, LENGTHOF operand_1 + LENGTHOF operand_2 + LENGTHOF sum
   mov ebx, TYPE operand_1
   call DumpMem
   call Crlf
   call Crlf

   ; reset text color to white
   mov eax, white
   call SetTextColor

   ; prompt proverb
   mov  edx, OFFSET prompt_proverb
   call WriteString

   ; set input text color
   mov eax, yellow
   call SetTextColor

   ; read string
   mov  ecx, SIZEOF aString - 1
   mov  edx, OFFSET aString
   call ReadString
   call Crlf

   ; reset text color to white
   mov eax, white
   call SetTextColor

   ; display learned string
   mov edx, OFFSET response_str
   call WriteString
   
   ; set text color
   mov eax, color_code
   call SetTextColor

   mov  edx, OFFSET aString
   call WriteString
   call Crlf
   call Crlf

   ; reset text color to white
   mov eax, white
   call SetTextColor

   invoke ExitProcess,0
main endp
end main
