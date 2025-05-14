;Christian Ayala, CMSC313 HW11, Class Time M/W 1000am
;File name: translate2Ascii.asm

section .data
inputbuf:
    db 0x83,0x6A,0x88,0xDE,0x9A,0xC3,0x54,0x9A ;data to be output in ASCII format

section .bss
outputbuf:
    resb 80

section .text
global _start

_start:
    mov edi, outputbuf
    mov esi, inputbuf
    mov ecx, 8

convert_high:
    ;converting first half, ex 0x83 -> 0x8
   
    mov al, byte [esi] ; move the next byte into the 8 bit al register
    AND al, 0xF0 ; mask al to get only the high part/nibble
    shr al, 4 ; shift it to the end

    ; translate accordingly, depending whether it is a letter or a digit
    cmp al, 10
    jge ascii_high
    jmp digit_high
    
convert_low:
    ;converting second half ex 0x83 ->0x3
    ; same thing as upper bit, just different masking to get the low end of the byte and no need to shr

    mov al, byte [esi]
    AND al, 0x0F

    ; process accordingly, depending it is a letter or a digit
    cmp al, 10
    jge ascii_low
    jmp digit_low
    
isdone:
    ; if not done it will go back to convert_high and keep looping
    ; will continue pass this block if it is done
    inc esi 
    dec ecx
    jnz convert_high

    ;add a newline
    mov byte [edi], 0X0A
    inc edi

    ;print the ascii
    sub edi, outputbuf
    mov eax, 4
    mov ebx, 1
    mov edx, edi
    mov ecx, outputbuf
    int 80h

    ; exit 0
    mov eax, 1
    mov ebx, 0
    int 80h

digit_high:
    ;add 0x30 to get the ASCII value of a number
    add al, 0x30
    mov [edi], al ; move the value into edi
    inc edi 
    ; jmp to the function that converts the low part
    jmp convert_low

ascii_high:
    ;add 0x37 to get the ASCII value of a letter
    add al, 0x37
    mov [edi], al ; move the value into edi
    inc edi 
    ; jmp to the function that converts the low part
    jmp convert_low


;digit_low and ascii_low is the same as the high, only difference is it jumps to isDone
digit_low:
    add al, 0x30
    mov [edi], al
    inc edi
    mov byte [edi], ' '
    inc edi
    ;check if done
    jmp isdone

ascii_low:
    add al, 0x37
    mov [edi], al
    inc edi
    mov byte [edi], ' '
    inc edi
    ; check if done
    jmp isdone
