[org 0x7c00]    ; Bootsector offset

mov bp, 0x8000  ; Set stack 
mov sp, bp

mov bx, 0x9000
mov dh, 2   ; Read 2 sectors 
; The bios sets dl as boot disk number 

call disk_load 

mov dx, [0x9000]    ; First sector, 0xdada
call print_hex 

call print_endline

mov dx, [0x9000 + 512] ; Second sector, 0xface 
call print_hex

jmp $

%include "boot_sector_print.nasm"
%include "boot_sector_print_hex.nasm"
%include "boot_sector_disk.nasm"

; Fill with 510 zeros
times 510-($-$$) db 0

dw 0xaa55

; Sectors 1 and 2
times 256 dw 0xdada 
times 256 dw 0xface