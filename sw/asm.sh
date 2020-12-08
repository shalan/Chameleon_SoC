name=$(echo $1 | cut -f 1 -d '.')
/usr/local/opt/riscv-gnu-toolchain/bin/riscv64-unknown-elf-as --march=rv32ic -o $name.elf $1
/usr/local/opt/riscv-gnu-toolchain/bin/riscv64-unknown-elf-objcopy -O verilog $name.elf $name.hex
/usr/local/opt/riscv-gnu-toolchain/bin/riscv64-unknown-elf-objcopy -O binary $name.elf $name.bin
/usr/local/opt/riscv-gnu-toolchain/bin/riscv64-unknown-elf-objdump -d $name.elf > $name.asm 
