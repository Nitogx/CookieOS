/* linker.ld - CookieOS Linker Script */

ENTRY(_start)

SECTIONS
{
    . = 0x8000;
    
    .text : {
        *(.text*)
    }
    
    .rodata : {
        *(.rodata*)
    }
    
    .data : {
        *(.data*)
    }
    
    .bss : {
        *(.bss*)
        *(COMMON)
    }
    
    /DISCARD/ : {
        *(.note*)
        *(.comment)
        *(.eh_frame)
        *(.rela*)
    }
}