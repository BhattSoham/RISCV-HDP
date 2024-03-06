delay(int):
        addi    sp,sp,-16
        sd      ra,8(sp)
        sd      s0,0(sp)
        mv      s0,a0
        call    clock
        add     s0,s0,a0
.L2:
        call    clock
        blt     a0,s0,.L2
        ld      ra,8(sp)
        ld      s0,0(sp)
        addi    sp,sp,16
        jr      ra
.LC0:
        .string "Count value is: %d\n"
display(int):
        addi    sp,sp,-16
        sd      ra,8(sp)
        mv      a1,a0
        lui     a0,%hi(.LC0)
        addi    a0,a0,%lo(.LC0)
        call    printf
        ld      ra,8(sp)
        addi    sp,sp,16
        jr      ra
main:
        addi    sp,sp,-32
        sd      ra,24(sp)
        sd      s0,16(sp)
        sd      s1,8(sp)
        sd      s2,0(sp)
        li      s0,0
        li      s1,16
        li      s2,0
        j       .L9
.L8:
        li      a0,500
        call    delay(int)
.L9:
        mv      a0,s0
        call    display(int)
        addiw   s0,s0,1
        bne     s0,s1,.L8
        mv      s0,s2
        j       .L8
