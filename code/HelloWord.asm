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
    syscall
    jmp _quitter

_quitter:
    mov rax, 60
    mov rdi, 0
    syscall




