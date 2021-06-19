BITS 64

global _start

section .bss
    entree resb 64
    entreeTaille equ $-entree

section .data
    affichage dq "Votre saisi est:"
    affichageTaille equ $-affichage

section .text

_start:
    jmp _lire

_lire:
    mov rax, 0
    mov rdi, 0
    mov rsi, entree
    mov rdx, entreeTaille
    syscall
    jmp _ecrire

_ecrire:
    mov rax, 1
    mov rdi, 1
    mov rsi, affichage
    add rsi, entree
    mov rdx, affichageTaille
    add rdx, entreeTaille
    syscall
    jmp _quitter

_quitter:
    mov rax, 60
    mov rdi, 0
    syscall