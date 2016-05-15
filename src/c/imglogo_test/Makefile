# microAptiv_UP makefile for MIPSfpga

ifndef MIPS_ELF_ROOT
$(error MIPS_ELF_ROOT must be set to point to toolkit installation root)
endif

CC=mips-mti-elf-gcc
LD=mips-mti-elf-ld
OD=mips-mti-elf-objdump
OC=mips-mti-elf-objcopy
SZ=mips-mti-elf-size

CFLAGS=-O3 -g -EL -c -msoft-float -march=m14kec -msoft-float -mno-dsp -mno-dspr2 -mno-dspr3
LDFLAGS_FPGA_RAM=-T FPGA_Ram.ld -EL -nostdlib -march=m14kec -mno-mips16 -mno-micromips -mno-dsp -mno-dspr2 -mno-dspr3 -msoft-float -Wl,-Map=FPGA_Ram_map.txt

ASOURCES= \
boot.S

CSOURCES= \
main.c

all: FPGA_RAM

COBJECTS=$(CSOURCES:.c=.o)
AOBJECTS=$(ASOURCES:.S=.o)

FPGA_RAM : $(AOBJECTS) $(COBJECTS) 
	$(CC)  $(LDFLAGS_FPGA_RAM) $(COBJECTS) -o FPGA_Ram.elf
	$(SZ) FPGA_Ram.elf
	$(OD) -d -S -l FPGA_Ram.elf > FPGA_Ram_dasm.txt
	$(OD) -d FPGA_Ram.elf > FPGA_Ram_modelsim.txt
	$(OC) FPGA_Ram.elf -O srec FPGA_Ram.rec
	
.c.o:
	$(CC) $(CFLAGS) $< -o $@
	
.S.o:
	$(CC) $(CFLAGS) $< -o $@

clean:
	rm -f FPGA_Ram_dasm.txt
	rm -f FPGA_Ram_modelsim.txt
	rm -f FPGA_Ram_map.txt
	rm -f FPGA_Ram.rec
	rm -f FPGA_Ram.elf
	rm -f *.o
	rm -rf MemoryFiles

	
