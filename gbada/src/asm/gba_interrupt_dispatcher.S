
    .arm
    .align
    .global gba_run_handler_in_system_mode
    .section .iwram, "ax", %progbits

    @ starts running in IRQ mode, with interrupts disabled.
    @ r0 : handler code pointer

gba_run_handler_in_system_mode:
    @ save spsr and return address
    mrs     r2, spsr
    push    {r2, lr}

    @ Set mode to sys
    mrs     r3, cpsr
    bic     r3, r3, #0xDF
    orr     r3, r3, #0x1F
    msr     cpsr, r3

    @ Call handler
    push    {lr}
    mov      lr, pc
    bx       r0
    pop     {lr}
    
    mov     r0, #0
    mov     r1, #0x4000000
    strb    r0, [r1, #208] @ clear IME again (safety) (?)

    @ Reset mode to irq
    mrs     r3, cpsr
    bic     r3, r3, #0xDF
    orr     r3, r3, #0x92
    msr     cpsr, r3

    @ Restore original spsr, lr
    pop     {r2, lr}
    msr     spsr, r2 
    bx      lr