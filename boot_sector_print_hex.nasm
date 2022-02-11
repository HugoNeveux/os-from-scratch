; print_hex recieves data in dx register
print_hex:
    pusha ; Save registers
    mov cx, 0 ; Index var 

hex_loop: 
    cmp cx, 4
    je end 

    ; Convert last char of 'dx' to ascii
    mov ax, dx 
    and ax, 0x000f
    add al, 0x30 ; Convert to ASCII
    cmp al, 0x39 ; If > 9, add extra 8 to represent 'A' to 'F'
    jle step2
    add al, 7

step2:
    mov bx, HEX_OUT + 5
    sub bx, cx 
    mov [bx], al 
    ror dx, 4

    inc cx
    jmp hex_loop

end:
    mov bx, HEX_OUT
    call print

    popa 
    ret 

HEX_OUT:
    db '0x0000', 0