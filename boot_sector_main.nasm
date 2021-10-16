[org 0x7c00]    ; Bootsector offset

mov ah, 0x0e

mov bx, STRING
call print_endline

mov bx, STRING2
call print_endline

mov dx, 0x12fe 
call print_hex 

jmp $

%include "boot_sector_print.nasm"
%include "boot_sector_print_hex.nasm"

STRING:
    db 'Hello world !', 0

STRING2:
    db 'Goodbye world.', 0

; Fill with 510 zeros
times 510-($-$$) db 0

dw 0xaa55