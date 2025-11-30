; KERNEL.asm - fuck triple faults

[BITS 64]

global _start

_start:
    ; Immediate VGA write - no memory loads because i beg for no error
    mov byte [0xB8000], 'K'
    mov byte [0xB8001], 0x0E  ; Yellow
    
    ; Halt because uhhhh yk
    cli
.loop:
    hlt
    jmp .loop