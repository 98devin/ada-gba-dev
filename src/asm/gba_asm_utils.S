

    .text
    .cpu arm7tdmi
    .balign 2


    @ Routines to be called to allow easy returning of multiple registers.
    @ For example, these can be imported as `void (int, int, int, int)`
    @ and they will effectively allow returning four register values.

    .arm
    .global return_stub_arm
    .type   return_stub_arm, %function

return_stub_arm:
    bx  lr


    .thumb
    .global return_stub_thumb
    .type   return_stub_thumb, %function
    .thumb_func

return_stub_thumb:
    bx  lr


