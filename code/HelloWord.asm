bits 64

global _start


section .data
    maVar db "Hello World ! Je m'appelle Jérémy",10,0
    longueur equ $-maVar

section .text
_start:
    mov rax, 1
    mov rdi, 1
    mov rsi, maVar
    mov rdx, longueur
    int 0x80
    jmp _quitter

_quitter:
    mov rax, 60
    mov rdi, 0
    int 0x80




