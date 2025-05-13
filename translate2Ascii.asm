;Christian Ayala, CMSC313 HW11, Class Time M/W 1000am

section .data
inputbuf:
    db 0x83,0x6A,0x88,0xDE,0x9A,0xC3,0x54,0x9A ;data to be output in ASCII format
asciistuff:
    db '0123456789ABCDEF'

section .bss
outputbuf:
    resb 80

section .text
global _start

_start:
    mov edi, outputbuf
    mov esi, inputbuf
    mov ecx, 8

convert_bytes:

    ;converting first half, ex 0x83 -> 0x8
    ;use al so we only use 8 bits
    mov eax, 0
    mov al, byte [esi]
    AND al, 0xF0
    shr al, 4
    mov ah, [asciistuff+eax]
    mov [edi], ah
    inc edi

    ;converting second half ex 0x83 ->0x3

    mov eax, 0
    mov al, byte [esi]
    AND al, 0x0F
    mov ah, [asciistuff+eax]
    mov [edi], ah
    inc edi
    
    ; add a space and continue
    mov byte [edi], ' '
    inc edi

    ;if still more bytes, esi != 0 so keep looping
    inc esi 
    dec ecx
    jnz convert_bytes

    mov byte [edi], 0X0A
    inc edi
    

    ;print and exit
    sub edi, outputbuf
    mov eax, 4
    mov ebx, 1
    mov edx, edi
    mov ecx, outputbuf
    int 80h

    mov eax, 1
    mov ebx, 0
    int 80h

