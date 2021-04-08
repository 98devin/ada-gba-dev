
    .macro defn fname, id

    .section bios_thumb__\fname\().text, "ax", %progbits
    .global bios_thumb__\fname
    .type   bios_thumb__\fname, %function

    .thumb_func

bios_thumb__\fname\():
    swi \id
    bx lr

    .endm

    .text
	.cpu arm7tdmi
    .balign 2
    .thumb


    .include "gba_bios_common.inc"