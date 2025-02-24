
section .data
    ; Define an error message
    err_msg db "Error: Invalid input", 10  ; Message to display on invalid input, followed by a newline character
    err_len equ $ - err_msg                ; Calculate the length of the error message

section .bss
    ; Allocate buffer for input
    input resb 100    ; Reserve 100 bytes to store user input
    result resb 2     ; Reserve 2 bytes to store the result (1 for the digit, 1 for newline)

section .text
    global _start     ; Declare the entry point for the program

_start:
    ; Read user input from stdin
    mov eax, 3          ; syscall: sys_read
    mov ebx, 0          ; file descriptor: stdin (0)
    mov ecx, input      ; buffer to store input
    mov edx, 100        ; maximum number of bytes to read
    int 0x80            ; invoke syscall

    ; Parse the first number from input
    mov al, [input]     ; Load first character from input buffer
    sub al, '0'         ; Convert ASCII digit to integer (subtract ASCII '0')
    mov bl, al          ; Store first number in BL register

    ; Check if the second character is a space
    mov al, [input + 1] ; Load second character from input
    cmp al, ' '         ; Compare it with a space character
    jne error           ; If not a space, jump to error handling

    ; Parse the second number from input
    mov al, [input + 2] ; Load third character (second number)
    sub al, '0'         ; Convert ASCII digit to integer

    ; Check if the fourth character is a plus sign
    mov cl, [input + 4] ; Load the fifth character from input
    cmp cl, '+'         ; Compare it with '+'
    jne error           ; If not a plus sign, jump to error handling

    ; Perform addition
    add al, bl          ; Add first and second number

    ; Convert sum back to ASCII
    add al, '0'         ; Convert back to ASCII
    mov [result], al    ; Store result in buffer

    ; Print the result
    mov eax, 4          ; syscall: sys_write
    mov ebx, 1          ; file descriptor: stdout (1)
    mov ecx, result     ; buffer containing the result
    mov edx, 1          ; length of output (1 character)
    int 0x80            ; invoke syscall

    ; Print a newline character
    mov byte [result], 10   ; Store newline character
    mov eax, 4          ; syscall: sys_write
    mov ebx, 1          ; file descriptor: stdout (1)
    mov ecx, result     ; buffer containing newline
    mov edx, 1          ; length (1 character)
    int 0x80            ; invoke syscall

    ; Exit program successfully
    mov eax, 1          ; syscall: sys_exit
    mov ebx, 0          ; exit code 0 (success)
    int 0x80            ; invoke syscall

error:
    ; Print error message
    mov eax, 4          ; syscall: sys_write
    mov ebx, 1          ; file descriptor: stdout (1)
    mov ecx, err_msg    ; buffer containing error message
    mov edx, err_len    ; length of error message
    int 0x80            ; invoke syscall

    ; Exit program with an error code
    mov eax, 1          ; syscall: sys_exit
    mov ebx, 1          ; exit code 1 (error)
    int 0x80            ; invoke syscall
