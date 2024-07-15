global long_mode_start
extern kernel_main

section .text
bits 64

long_mode_start:
    mov ax, 0 ; load null into all data segment registers
    mov ss, ax
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    ; mov dword [0xB8000], 0x2F4B2F4F ; print 'OK'
    call kernel_main

    hlt
