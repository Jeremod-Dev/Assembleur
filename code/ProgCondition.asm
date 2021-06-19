BITS 64

global _start

section .bss
    age resb 8
    ageTaille equ $-age

section .rodata
    question db "Quel est votre age ? "
    questionTaille equ $-question

    majeur dw "Vous etes majeur en France.",10
    majeurTaille equ $-majeur

    mineur dw "Vous etes mineur en France.", 10
    mineurTaille equ $-mineur


section .text

_start:
    jmp _afficheQuestion

_afficheQuestion:
    mov rax, 1
    mov rdi, 1
    mov rsi, question
    mov rdx, questionTaille
    syscall
    jmp _saisir

_saisir:
    mov rax, 0
    mov rdi, 0
    mov rsi, age
    mov rdx, ageTaille
    syscall
    jmp _strToInt

_strToInt:
    jmp _condition

_condition:
    mov eax, 18
    cmp eax, age
    jg _mineur
    jmp _majeur

_mineur:
    mov rax, 1
    mov rdi, 1
    mov rsi, mineur
    mov rdx, mineurTaille
    syscall
    jmp _quitter

_majeur:
    mov rax, 1
    mov rdi, 1
    mov rsi, majeur
    mov rdx, majeurTaille
    syscall
    jmp _quitter
_quitter:
    mov rax, 60
    mov rdi, 0
    syscall
