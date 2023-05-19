bits 64

%define STACK_BS 1024
%define STACK_SIZE 16

section .text

extern main

_start:
    ; initialize stack
    mov esp, stack_space
    mov ebp, stack_end

    ; enter kernel
    call main

    ; ensure return 0
    cmp eax, 0
    jne .hang

    ret
.hang:
    ; infinite loop
    jmp .hang
    ret
    
section .bss

stack_space:
    times STACK_SIZE resb STACK_BS
stack_end: