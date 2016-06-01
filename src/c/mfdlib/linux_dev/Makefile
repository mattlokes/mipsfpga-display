CC=gcc
LD=ld
OD=objdump
OC=objcopy
SZ=size

CFLAGS= -I../ -O2 -g -c
LFLAGS= -I../ 

CSOURCES= \
main.c \
mfdlib_linux_dev.c

COBJECTS=$(CSOURCES:.c=.o)

all: bin

bin: $(COBJECTS) 
	$(CC) $(LFLAGS) $(COBJECTS) -o test -lpng
	
.c.o:
	$(CC) $(CFLAGS) $< -o $@ -lpng
	
clean:
	rm -f *.o
	rm -f test

	
