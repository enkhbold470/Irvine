# Introduction to x86 Processor Assembly Language and Architecture

## Assignments repo

Assignment 3 .lst file
00000000                                      .386
00000000                                      .model flat,stdcall
00000000                                      .stack 4096
00000000                                      ExitProcess proto,dwExitCode:dword

00000000                                      .code
00000000                                      main proc
00000000 B8 05 00 00 00                          mov     eax,5
; B8 = MOV r32, imm32 opcode. The following bytes (05 00 00 00) are the 
; immediate value 5 in little-endian format.

00000005 83 C0 06                                add     eax,6
; 83 = ADD r32, imm8 opcode. C0 indicates the register (EAX) as the destination.
; 06 is the immediate value to add.

00000008 6A 00                                   push    0
; 6A = PUSH imm8 opcode. 00 is the immediate value pushed onto the stack.

0000000A E8 00 00 00 00                          call    ExitProcess
; E8 = CALL rel32 opcode. The four zeros are a placeholder for the relative 
; address to ExitProcess. The assembler doesn't know the address yet, so it 
; inserts a relocation that will be fixed by the linker. At runtime, this will 
; call the ExitProcess function from the Windows API.

0000000F                                      main endp
0000000F                                      end main
