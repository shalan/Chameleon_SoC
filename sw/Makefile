gcc_path := /usr/local/opt/riscv-gnu-toolchain/bin
name := test

%.hex: $(name).c n5_drv.c crt0.S link.ld
	$(gcc_path)/riscv64-unknown-elf-gcc -Wall  -falign-functions=4 -march=rv32ic -mabi=ilp32 -nostdlib -mstrict-align -T link.ld -o $(name).elf -lgcc crt0.S n5_drv.c $(name).c  -lgcc
	$(gcc_path)/riscv64-unknown-elf-objcopy -O binary $(name).elf $(name).bin
	$(gcc_path)/riscv64-unknown-elf-objcopy -O verilog $(name).elf $(name).hex
	$(gcc_path)/riscv64-unknown-elf-objdump -D $(name).elf > $(name).lst

all: $(name).hex