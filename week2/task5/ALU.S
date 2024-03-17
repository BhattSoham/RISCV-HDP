	.file	"ALU.c"
	.option nopic
	.attribute arch, "rv64i2p0_m2p0_a2p0_f2p0_d2p0_c2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata
	.align	3
.LC0:
	.string	"Enter two numbers:"
	.align	3
.LC1:
	.string	"%d %d"
	.align	3
.LC2:
	.string	"Enter the operation from ADD, SUB, MUL, DIV, OR, AND, XOR : "
	.align	3
.LC3:
	.string	" %c"
	.align	3
.LC4:
	.string	"Wrong operation"
	.align	3
.LC5:
	.string	"Result is: %d"
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	printf
	addi	a4,s0,-28
	addi	a5,s0,-24
	mv	a2,a4
	mv	a1,a5
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	scanf
	lui	a5,%hi(.LC2)
	addi	a0,a5,%lo(.LC2)
	call	printf
	addi	a5,s0,-29
	mv	a1,a5
	lui	a5,%hi(.LC3)
	addi	a0,a5,%lo(.LC3)
	call	scanf
	lbu	a5,-29(s0)
	sext.w	a5,a5
	mv	a3,a5
	li	a4,45
	beq	a3,a4,.L2
	mv	a3,a5
	li	a4,45
	bgt	a3,a4,.L3
	mv	a3,a5
	li	a4,42
	beq	a3,a4,.L4
	mv	a3,a5
	li	a4,43
	beq	a3,a4,.L5
	mv	a4,a5
	li	a5,38
	beq	a4,a5,.L6
	j	.L7
.L3:
	mv	a3,a5
	li	a4,94
	beq	a3,a4,.L8
	mv	a3,a5
	li	a4,124
	beq	a3,a4,.L9
	mv	a4,a5
	li	a5,47
	beq	a4,a5,.L10
	j	.L7
.L5:
	lw	a4,-24(s0)
	lw	a5,-28(s0)
	addw	a5,a4,a5
	sw	a5,-20(s0)
	j	.L11
.L2:
	lw	a4,-24(s0)
	lw	a5,-28(s0)
	subw	a5,a4,a5
	sw	a5,-20(s0)
	j	.L11
.L4:
	lw	a4,-24(s0)
	lw	a5,-28(s0)
	mulw	a5,a4,a5
	sw	a5,-20(s0)
	j	.L11
.L10:
	lw	a4,-24(s0)
	lw	a5,-28(s0)
	divw	a5,a4,a5
	sw	a5,-20(s0)
	j	.L11
.L9:
	lw	a4,-24(s0)
	lw	a5,-28(s0)
	or	a5,a4,a5
	sw	a5,-20(s0)
	j	.L11
.L6:
	lw	a4,-24(s0)
	lw	a5,-28(s0)
	and	a5,a4,a5
	sw	a5,-20(s0)
	j	.L11
.L8:
	lw	a4,-24(s0)
	lw	a5,-28(s0)
	xor	a5,a4,a5
	sw	a5,-20(s0)
	j	.L11
.L7:
	lui	a5,%hi(.LC4)
	addi	a0,a5,%lo(.LC4)
	call	printf
	li	a5,1
	j	.L13
.L11:
	lw	a5,-20(s0)
	mv	a1,a5
	lui	a5,%hi(.LC5)
	addi	a0,a5,%lo(.LC5)
	call	printf
	li	a5,0
.L13:
	mv	a0,a5
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.ident	"GCC: (SiFive GCC 8.3.0-2019.08.0) 8.3.0"
