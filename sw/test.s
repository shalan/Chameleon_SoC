_start:
j main
.org 12
li x30, 0xABC
mret

main:
li  x1, 1   # 1
li  x2, 2   # 2
li  x3, 3   # 3
add x4, x1, x2  # 3
add x5, x4, x3  # 6
sub x6, x5, x2  # 4
addi x7, x6, 20 # 24
slti x8, x7, 10 # 0 
slti x9, x7, 100 #1
li x3, 3
jal fn1
li x12, 12
li x13, 1
li x14, 0

loop:
    bge x13, x12, loop_exit 
    add x14, x14, x13
    addi x13, x13, 1 
    j loop
loop_exit:

li x15, 15
lui x16, 0x222
auipc x17, 0x111
li  x20, 0x20000000
sw  x17, 0(x20)
lw  x21, 0(x20)
li x17, 0x8000
sh  x17, 6(x20)
lh  x22, 6(x20)
lhu  x23, 6(x20)
li x24, 0xFA
sb    x24, 9(x20)
lb    x25, 9(x20)
lbu     x26, 9(x20)

ebreak

fn1:
li x10, 10
addi x11, x10, 13
jr ra


