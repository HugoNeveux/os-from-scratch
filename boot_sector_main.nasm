[org 0x7c00]    ; Bootsector offset

mov ah, 0x0e

mov bx, STRING
call print_endline

mov bx, STRING2
call print_endline

jmp $

%include "boot_sector_print.nasm"

STRING:
    db 'Hello world !', 0

STRING2:
    db 'Goodbyle world.', 0

; Fill with 510 zeros
times 510-($-$$) db 0

dw 0xaa55