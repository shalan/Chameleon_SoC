//#define	EXT_MUL

#define r_type_insn(_f7, _rs2, _rs1, _f3, _rd, _opc) \
.word (((_f7) << 25) | ((_rs2) << 20) | ((_rs1) << 15) | ((_f3) << 12) | ((_rd) << 7) | ((_opc) << 0))

#define ext_mul(_rd, _rs1, _rs2) \
r_type_insn(0b0000000, _rs2, _rs1, 0b111, _rd, 0b0001011)

.macro wrtmrcmp reg
	csrrw   zero, 0xC03, \reg
.endm

.macro wrmie reg
	csrrw   zero, mie, \reg
.endm

.section .text
	.global _start
	

	.org 0
reset_vector:
	j		reset_hand
	.org 4
nmi_vector:
	j		nmi_hand
	.org 8
tmr_vector:
	j		tmr_hand
	.org 12
	j		.
	.org	16
ecall_vector:
	j		ecall_hand
	.org	20
ebreak_vector:
	j		ebreak_hand
	.org	24
	j		.
	.org	28
	j		.
	.org	64
	j		irq0_hand

	.org 128
reset_hand:
	# disable interrupts
	li t0, 0	#disable interrupts; use 5 to enable interrupts and IRQ
	wrmie t0
  _start:
	li	s0, 0
	li	s1, 0
	li	s2, 0
	li	s3, 0
	li	s4, 0
	li	s5, 0
	li	s6, 0
	li	s7, 0
	li	s8, 0
	li	s9, 0
	li	s10, 0
	li	s11, 0
	j		___App

	.align 8

nmi_hand:
tmr_hand:
ecall_hand:
ebreak_hand:
irq0_hand:
	li t0, 0xBAD00BED
	mret

.align 8
#ifdef EXT_MUL
.global __mulsi3
__mulsi3:
        ext_mul(10, 10, 11)
        ret
#endif

.align 8
___App:
	# Initialize the BSS section with 0s
init_bss:	
	la a0, __bss_start__
	la a1, __bss_end__
	bge a0, a1, end_init_bss
loop_init_bss:
	sw zero, 0(a0)
	addi a0, a0, 4
	blt a0, a1, loop_init_bss
end_init_bss:

	# Move initialized data to RAM
init_data:
	la a0, __idata__
	la a1, __data_start__
	la a2, __data_end__
	bge a1, a2, end_init_data
loop_init_data:
	lw a3, 0(a0)
	sw a3, 0(a1)
	addi a0, a0, 4
	addi a1, a1, 4
	blt a1, a2, loop_init_data
end_init_data:

	# Initialize the stack pointer!
	lui sp, %hi(_fstack)
	addi sp, sp, %lo(_fstack)
	jal main
	ebreak;

	.align 8


