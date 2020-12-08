all: sim
.PHONY: all

test.hex: ../sw/test.c ../sw/crt0.S ../sw/link.ld 
	$(MAKE) -C ../sw/ all

test.vvp: test.hex files.list
	iverilog -o test.vvp -D TEST_FIL="../sw/test.hex" -c files.list

sim: test.vvp
	./test.vvp


clean:
	rm *.vvp
	rm -f ../sw/*.hex ../sw/*.elf ../sw/*.lst 