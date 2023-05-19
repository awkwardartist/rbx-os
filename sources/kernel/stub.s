bits 64

%define STACK_BS 1024
%define STACK_SIZE 16

section .text

extern main

_start:
    ; 
    mov esp, stack_space
    mov ebp, stack_end

    call main
    ret

section .bss

stack_space:
    times STACK_SIZE resb STACK_BS
stack_end: