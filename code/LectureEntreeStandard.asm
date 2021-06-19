BITS 64

global _start

section .bss ; section dédiés aux variables déclarées mais non initialisé
    entree resb 64 ;reservation de memoire
    entreeTaille equ $-entree ; recuperation de la taille de entree

section .text ; section du code source du programme

_start:
    mov rax, 0 ; id de l'appel systeme
    mov rdi, 0 ; entree standard (stdin = 0)
    mov rsi, entree
    mov rdx, entreeTaille
    syscall ; appel systeme
    jmp _afficher ;saut jusqu'a _afficher

_afficher:
    mov rax, 1 ; id de l'appel systeme
    mov rdi, 1 ; sorti standard (stdout = 1)
    mov rsi, entree
    mov rdx, entreeTaille
    syscall ; appel systeme
    jmp _quitter ; saut jusqu'a _quitter

_quitter:
    mov rax, 60 ; id de l'appel systeme
    mov rdi, 0 ; id du code error a retourner
    syscall ; appel systeme
