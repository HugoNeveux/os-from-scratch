; Load dh sectors from drive dl into ES:BX
disk_load:
    pusha ; Backing up registers to stack
    push dx ; Backing up dx for later use 

    mov ah, 0x02    ; call 0x02 from int 0x13 : read
    mov al, dh  ; Number of sectors to read 
    mov cl, 0x02    ; Sector number. 0x01 is boot sector 
    mov ch, 0x00    ; Cylinder 
    mov dh, 0x00    ; Head number 

    ; [es:bx] buffer where data will be stored 
    int 0x13    ; Interrupt 
    jc disk_error   ; Carry bit

    pop dx 
    cmp al, dh  ; Number of sectors read 
    jne sectors_error 
    popa 
    ret 

disk_error: 
    mov bx, DISK_ERROR 
    call print_endline 

    mov dh, ah  ; ah : error code, dl : disk_drive that dropped the error
    call print_hex 
    jmp disk_loop 

sectors_error:
    mov bx, SECTORS_ERROR 
    call print

disk_loop:
    jmp $

DISK_ERROR: db "Disk read error", 0
SECTORS_ERROR: db "Incorrect number of sectors read", 0