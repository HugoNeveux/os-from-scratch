; Global descriptor table 
gdt_start:

gdt_null:   ; Starting with null 8-byte (GDT null descriptor)
    dd 0x0  ; dd : Define Double word
    dd 0x0

gdt_code:
    ; 1st flags : (present)1 (privilege)00 (descriptor type)1 : 1001b
    ; type flags : (code)1 (conforming)0 (readable)1 (accessed)0 -> 1010b
    ; 2nd flags : (granularity)1 (32-bit default)1 (64-bit seg)0 (AVL)0 -> 1100b
    dw 0xffff   ; Limit
    dw 0x0  ; Base 
    db 0x0  ; Base
    db 10011010b    ; Type flags
    db 11001111b    ; Second flags and Limit 
    db 0x0  ; Base

gdt_data:
    ; Only type flags change
    ; type flags : (code)0 (expand down)0 (writable)1 (accessed)0 -> 0010b
    dw 0xffff   ; Limit 
    dw 0x0  ; Base
    db 0x0  ; Base
    db 10010010b    ; First flags & type flags
    db 11001111b    ; 2nd flags, limit 
    db 0x0  ; Base

gdt_end:
    ; Allows to calculate the size of the GDT for the GDT descriptor

gdt_descriptor:
    dw gdt_end - gdt_start - 1  ; Size of our GDT
    dd gdt_start    ; Start address of the GDT

; Defining some constants for the GDT segment descriptor offsets
CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start 