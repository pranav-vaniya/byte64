section .multiboot_header

header_start:
    dd 0xE85250D6 ; MAGIC NUMBER
    dd 0 ; protected mode
    dd header_end - header_start ; header length
    dd 0x100000000 - (0xE85250D6 + 0 + (header_end - header_start)) ; checksum

    dw 0 ; end tag
    dw 0
    dd 8

header_end: