[bits 32]   ; 32 bit protected mode

VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

print_string_pm:
    pusha 
    mov edx, VIDEO_MEMORY

print_string_pm_loop:
    mov al, [ebx]   ; char is in ebx 
    mov ah, WHITE_ON_BLACK

    cmp al, 0   ; Check if end of string
    jp print_string_pm_done 

    mov [edx], ax
    inc ebx 
    add edx, 2

    jmp print_string_pm_loop

print_string_pm_done:
    popa 
    ret 