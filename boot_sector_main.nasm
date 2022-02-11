[org 0x7c00]    ; Bootsector offset
    mov bp, 0x9000
    mov sp, bp

    mov bx, MSG_REAL_MODE
    call print
    call print_endline

    call switch_to_pm

    jmp $

%include "boot_sector_print.nasm"
%include "32bit-gdt.nasm"
%include "32bit-print.nasm"
%include "switch_to_pm.nasm"

[bits 32]
BEGIN_PM:
    mov ebx, MSG_PROT_MODE
    call print_string_pm

    jmp $

MSG_REAL_MODE db "Successfully started in real mode.", 0
MSG_PROT_MODE db "Successfully switched to protected mode.", 0

; Fill with 510 zeros
times 510-($-$$) db 0

dw 0xaa55