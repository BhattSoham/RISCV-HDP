.LC0:
        .string "Enter two numbers:"
.LC1:
        .string "%d %d"
.LC2:
        .string "The final result is: %d \n"
main:
        addi    sp,sp,-32
        sw      ra,28(sp)
        sw      s0,24(sp)
        addi    s0,sp,32
        lui     a5,%hi(.LC0)
        addi    a0,a5,%lo(.LC0)
        call    printf
        addi    a4,s0,-28
        addi    a5,s0,-24
        mv      a2,a4
        mv      a1,a5
        lui     a5,%hi(.LC1)
        addi    a0,a5,%lo(.LC1)
        call    __isoc99_scanf
        lw      a4,-24(s0)
        lw      a5,-28(s0)
        add     a5,a4,a5
        sw      a5,-20(s0)
        lw      a1,-20(s0)
        lui     a5,%hi(.LC2)
        addi    a0,a5,%lo(.LC2)
        call    printf
        li      a5,0
        mv      a0,a5
        lw      ra,28(sp)
        lw      s0,24(sp)
        addi    sp,sp,32
        jr      ra
