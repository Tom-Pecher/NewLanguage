section .data
    ; Define error messages
    err_msg db "Error: Invalid input", 10
    err_len equ $ - err_msg

section .bss
    ; Buffer for reading input
    input resb 100
    result resb 2  ; Store result as ASCII

section .text
    global _start

_start:
    ; Read input from stdin
    mov eax, 3          ; sys_read
    mov ebx, 0          ; stdin
    mov ecx, input      ; buffer
    mov edx, 100        ; max length
    int 0x80

    ; Parse first number
    mov al, [input]
    sub al, '0'         ; Convert ASCII to number
    mov bl, al          ; Store first number in bl

    ; Check if second character is space
    mov al, [input + 1]
    cmp al, ' '
    jne error

    ; Parse second number
    mov al, [input + 2]
    sub al, '0'         ; Convert ASCII to number

    ; Check if fourth character is '+'
    mov cl, [input + 4]
    cmp cl, '+'
    jne error

    ; Add numbers
    add al, bl          ; Add first and second number

    ; Convert result back to ASCII
    add al, '0'
    mov [result], al

    ; Print result
    mov eax, 4          ; sys_write
    mov ebx, 1          ; stdout
    mov ecx, result     ; result buffer
    mov edx, 1          ; length
    int 0x80

    ; Print newline
    mov byte [result], 10   ; newline character
    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, 1
    int 0x80

    ; Exit successfully
    mov eax, 1          ; sys_exit
    mov ebx, 0          ; exit code 0
    int 0x80

error:
    ; Print error message
    mov eax, 4          ; sys_write
    mov ebx, 1          ; stdout
    mov ecx, err_msg    ; error message
    mov edx, err_len    ; length
    int 0x80

    ; Exit with error
    mov eax, 1          ; sys_exit
    mov ebx, 1          ; exit code 1
    int 0x80
