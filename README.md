# 313HW11

Author: Christian Ayala, CS46491. 
Email: cayala2@umbc.edu
Class Time: 1000am M/W

Program Description: 

This program takes bytes, in this case 0x83,0x6A,0x88,0xDE,0x9A,0xC3,0x54,0x9A and translates them to ASCII. The expected output is 83 6A 88 DE 9A C3 54 9A


TO COMPILE: 

Download translate2Ascii.asm


do the following commands on either GL or anywhere that uses a x86 intel processor: 


nasm -f elf32 -g -F dwarf -o translate2Ascii.o translate2Ascii.asm


ld -m elf_i386 -o translate2Ascii translate2Ascii.o

To RUN: ./translate2Ascii

Below are images of compiling and of what my code will produce:

![image](https://github.com/user-attachments/assets/db9583a0-790f-4e92-9105-32b5fabbef29)
