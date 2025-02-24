
section .text
    global _start

_start:
    mov rax, 3 
    add rax, 5
    mov rdi, rax
    mov rax, 60
    syscall
