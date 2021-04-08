
    .macro defn fname, id

    .section .iwram.\()bios_arm__\fname, "ax", %progbits
    .global bios_arm__\fname
    .type   bios_arm__\fname, %function

bios_arm__\fname\():
    swi \id\()0000
    bx lr

    .endm

    .text
	.cpu arm7tdmi
    .balign 4
    .arm


    .include "gba_bios_common.inc"