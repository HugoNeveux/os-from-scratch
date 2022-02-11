[bits 16]
; Switch to 32-bit protected mode
switch_to_pm:
    cli     ; Disable interrupts
    lgdt [gdt_descriptor]   ; Load GDT, which defines the protected mode segments
    ; Change first bit of cr0 to switch to protected mode
    mov eax, cr0
    or  eax, 0x1    ; Use OR to set the first bit only
    mov cr0, eax    ; Set PE flag in cr0 register
    jmp CODE_SEG:init_pm    ; Make a far jump to flush the GPU cache

[bits 32]
; Initialize 32-bit protected mode
init_pm:
    ; Point all segment registers to those defined in our GDT table
    mov ax, DATA_SEG
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x90000    ; Update the stack position
    mov esp, ebp

    call BEGIN_PM