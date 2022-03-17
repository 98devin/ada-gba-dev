
    .global font_begin
    .global font_end

    .section .rodata.unscii

    .align 4

font_begin:
    .incbin "unscii.bin"
font_end: