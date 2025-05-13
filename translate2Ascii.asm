;Christian Ayala, CMSC313 HW11, Class Time M/W 1000am

section .data
inputbuf:
    db 0x83,0x6A,0x88,0xDE,0x9A,0xC3,0x54,0x9A ;data to be output in ASCII format
length:
    equ 8

section .bss
outputbuf:
    resb 80

section .text
global _start

_start:
    mov edi, outputbuf
    mov esi, inputbuf
    mov ecx, length

loop_and_convert:

    ;converting first half, ex 0x83 -> 0x8
    ;use al so we only use 8 bits
    mov al, [esi]
    AND al, 0xF0
    shr al, 4


    ;converting second half ex 0x83 ->0x3

    mov al, [esi]
    AND al, 0x0F
    
    inc esi ;get next byte and loop again
    loop loop_and_convert
    

    ;print and exit
    mov eax, 4
    mov ebx, 1
    mov ecx, outputbuf
    int 80h

    mov eax, 1
    xor eax, ebx
    int 80h

