@ Copyright (c) 2021 Devin Hill
@ zlib License -- see LICENSE for details.

    @
    @ GBA.Numerics fast pure-assembly routines.
    @

    .arm
    .section .iwram.usqrt
    .global usqrt

    @ fast sqrt referenced from:
    @ http://www.pertinentdetail.org/sqrt

    @ IN  :  n 32 bit unsigned integer
    @ OUT :  root = INT (SQRT (n))

    @ root   : r0
    @ n      : r1
    @ offset : r2

usqrt:

    mov     r1, r0
    mov     r2, #3 << 30
    mov     r0, #1 << 30

    .macro loopbody i
    cmp     r1, r0, ror #2 * \i
    subhs   r1, r1, r0, ror #2 * \i
    adc     r0, r2, r0, lsl #1
    .endm

    loopbody 0
    loopbody 1
    loopbody 2
    loopbody 3
    loopbody 4
    loopbody 5
    loopbody 6
    loopbody 7
    loopbody 8
    loopbody 9
    loopbody 10
    loopbody 11
    loopbody 12
    loopbody 13
    loopbody 14
    loopbody 15

    bic     r0, r0, #3 << 30
    bx      lr
    @ for rounding add: CMP n, root  ADC root, #1