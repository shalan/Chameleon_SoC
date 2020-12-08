ENTRY(_start)

MEMORY
{
    FLASH (x) :
        ORIGIN = 0x0
        LENGTH = 1M
    SRAM (rwx) :
        ORIGIN = 0x20000000,
        LENGTH = 64K
    stack (rw):
        ORIGIN = 0x20000000 + 48K
        LENGTH = 16K
}

PROVIDE(_fstack = ORIGIN(stack) + LENGTH(stack) - 4);

SECTIONS
{
    .text : {
        *(.text*)
        *(.rodata*)
        . = ALIGN(8);
        __idata__ = .;
    } > FLASH
    
    .bss (NOLOAD) :
    {
        __bss_start__ = .;
        *(.bss*)
        *(COMMON)
        __bss_end__ = .;
    } > SRAM

    .data : 
    {
        __data_start__ = .;
        *(.data*);
        __data_end__ = .;
        
    } > SRAM AT > FLASH

}

