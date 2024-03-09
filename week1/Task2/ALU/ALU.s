.LC0:
        .string "Enter two numbers:"
.LC1:
        .string "%d %d"
.LC2:
        .string "Enter the operation from ADD, SUB, MUL, DIV, OR, AND, XOR : "
.LC3:
        .string " %c"
.LC4:
        .string "Wrong operation"
.LC5:
        .string "Result is: %d"
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
        lui     a5,%hi(.LC2)
        addi    a0,a5,%lo(.LC2)
        call    printf
        addi    a5,s0,-29
        mv      a1,a5
        lui     a5,%hi(.LC3)
        addi    a0,a5,%lo(.LC3)
        call    __isoc99_scanf
        lbu     a5,-29(s0)
        li      a4,124
        beq     a5,a4,.L2
        li      a4,124
        bgt     a5,a4,.L3
        li      a4,47
        bgt     a5,a4,.L4
        li      a4,38
        blt     a5,a4,.L3
        addi    a5,a5,-38
        li      a4,9
        bgtu    a5,a4,.L3
        slli    a4,a5,2
        lui     a5,%hi(.L6)
        addi    a5,a5,%lo(.L6)
        add     a5,a4,a5
        lw      a5,0(a5)
        jr      a5
.L6:
        .word   .L10
        .word   .L3
        .word   .L3
        .word   .L3
        .word   .L9
        .word   .L8
        .word   .L3
        .word   .L7
        .word   .L3
        .word   .L5
.L4:
        li      a4,94
        beq     a5,a4,.L11
        j       .L3
.L8:
        lw      a4,-24(s0)
        lw      a5,-28(s0)
        add     a5,a4,a5
        sw      a5,-20(s0)
        j       .L12
.L7:
        lw      a4,-24(s0)
        lw      a5,-28(s0)
        sub     a5,a4,a5
        sw      a5,-20(s0)
        j       .L12
.L9:
        lw      a4,-24(s0)
        lw      a5,-28(s0)
        mul     a5,a4,a5
        sw      a5,-20(s0)
        j       .L12
.L5:
        lw      a4,-24(s0)
        lw      a5,-28(s0)
        div     a5,a4,a5
        sw      a5,-20(s0)
        j       .L12
.L2:
        lw      a4,-24(s0)
        lw      a5,-28(s0)
        or      a5,a4,a5
        sw      a5,-20(s0)
        j       .L12
.L10:
        lw      a4,-24(s0)
        lw      a5,-28(s0)
        and     a5,a4,a5
        sw      a5,-20(s0)
        j       .L12
.L11:
        lw      a4,-24(s0)
        lw      a5,-28(s0)
        xor     a5,a4,a5
        sw      a5,-20(s0)
        j       .L12
.L3:
        lui     a5,%hi(.LC4)
        addi    a0,a5,%lo(.LC4)
        call    printf
        li      a5,1
        j       .L14
.L12:
        lw      a1,-20(s0)
        lui     a5,%hi(.LC5)
        addi    a0,a5,%lo(.LC5)
        call    printf
        li      a5,0
.L14:
        mv      a0,a5
        lw      ra,28(sp)
        lw      s0,24(sp)
        addi    sp,sp,32
        jr      ra
