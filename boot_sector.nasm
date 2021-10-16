mov ah, 0x0e

mov bp, 0x8000 ; Stack definition
mov sp, bp 

push 'A'
push 'B'
push 'C'

; Shouldn't work
mov al, [0x8000]
int 0x10

; Pop characters, using auxiliary register to use the lower byte only
pop bx
mov al, bl
int 0x10

pop bx
mov al, bl
int 0x10 

pop bx
mov al, bl
int 0x10

mov al, [0x800]
int 0x10

jmp $

; Fill with 510 zeros
times 510-($-$$) db 0

dw 0xaa55