print:
    pusha 

start:
    ; Print a string using a loop
    mov al, [bx]
    cmp al, 0
    je done

    mov ah, 0x0e
    int 0x10

    inc bx
    jmp start

done:
    popa 
    ret 

print_endline:
    ; Print with endline
    call print 
    mov ah, 0x0e 
    mov al, 0x0A
    int 0x10
    mov al, 0x0D
    int 0x10
    ret