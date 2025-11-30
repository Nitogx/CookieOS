; BOOT.asm - CookieOS Bootloader (Optimized to fit 512 bytes)

[BITS 16]
[ORG 0x7C00]

start:
    cli
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00
    sti

    ; Save drive number
    mov [drive_num], dl

    ; Enable A20
    in al, 0x92
    or al, 2
    out 0x92, al

    ; Load kernel using CHS (simpler, smaller code)
    mov ah, 0x02
    mov al, 32
    mov ch, 0
    mov cl, 2
    mov dh, 0
    mov dl, [drive_num]
    xor bx, bx      ; Load to 0x0000:0x8000 = 0x8000
    mov es, bx
    mov bx, 0x8000
    int 0x13

    ; Load GDT
    lgdt [gdt_desc]

    ; Enter protected mode
    mov eax, cr0
    or eax, 1
    mov cr0, eax
    jmp 0x08:pm_start

; GDT
gdt_start:
    dq 0
    dw 0xFFFF, 0, 0x9A00, 0x00CF
    dw 0xFFFF, 0, 0x9200, 0x00CF
gdt_end:

gdt_desc:
    dw gdt_end - gdt_start - 1
    dd gdt_start

[BITS 32]
pm_start:
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov esp, 0x90000

    ; Setup paging
    mov edi, 0x70000
    mov cr3, edi
    xor eax, eax
    mov ecx, 4096
    rep stosd
    mov edi, cr3

    ; PML4[0] -> PDPT at 0x71000
    mov dword [edi], 0x71003
    
    ; PDPT[0] -> PDT at 0x72000
    mov dword [0x71000], 0x72003
    
    ; Map first 2GB with 2MB pages (1024 entries)
    mov edi, 0x72000
    mov eax, 0x00000083     ; Present + RW + Huge + User
    mov ecx, 1024           ; Map 1024 * 2MB = 2GB
.lp:
    mov [edi], eax
    add eax, 0x200000
    add edi, 8
    loop .lp

    ; Enable PAE
    mov eax, cr4
    or eax, 0x20
    mov cr4, eax

    ; Enable long mode
    mov ecx, 0xC0000080
    rdmsr
    or eax, 0x100
    wrmsr

    ; Enable paging
    mov eax, cr0
    or eax, 0x80000000
    mov cr0, eax

    lgdt [gdt64_desc]
    jmp 0x08:long_mode

; 64-bit GDT
gdt64_start:
    dq 0, 0x00209A0000000000, 0x0000920000000000
gdt64_desc:
    dw 23
    dd gdt64_start

[BITS 64]
long_mode:
    mov ax, 0x10
    mov ds, ax
    mov ss, ax
    mov rsp, 0x90000

    ; Write 'GO' 
    mov dword [0xB8000], 0x0F4F0F47
    
    ; NO DELAY - write K immediately
    mov dword [0xB8002], 0x0E4B0E4B  ; 'KK' in yellow
    
    ; Halt
    cli
    hlt
    jmp $

drive_num: db 0

times 510-($-$$) db 0
dw 0xAA55