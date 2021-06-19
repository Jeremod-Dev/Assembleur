BITS 64

global _start

section .bss
    entree resb 64
    entreeTaille equ $-entree

section .data
    consigne dd "Saisissez quelque chose: "
    consigneTaille equ $-consigne
    affichage dd "Votre saisi est: "
    affichageTaille equ $-affichage

section .text

_start:
    jmp _lire

_lire:
    ;affichage de la consigne
    mov rax, 1
    mov rdi, 1
    mov rsi, consigne
    mov rdx, consigneTaille
    syscall
    ;lecture de l'entree stdin
    mov rax, 0
    mov rdi, 0
    mov rsi, entree
    mov rdx, entreeTaille
    syscall
    jmp _ecrire

_ecrire:
    ;affichage de "Votre saisi est: "
    mov rax, 1
    mov rdi, 1
    mov rsi, affichage
    mov rdx, affichageTaille
    syscall
    ; affichage de la saisi
    mov rax, 1
    mov rdi, 1
    mov rsi, entree
    mov rdx, entreeTaille
    syscall
    jmp _quitter

_quitter:
    mov rax, 60
    mov rdi, 0
    syscall