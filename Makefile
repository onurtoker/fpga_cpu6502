C_SOURCES = main.c
ASM_SOURCES = startup.s vectors.s interrupt.s
ROMIMG = firmware

CA65 = ca65
CC65 = cc65
CL65 = cl65
CAFLAGS  = --cpu 6502
CCFLAGS  = --cpu 6502 -O -t none
CLFLAGS  = -t none -O --cpu 6502 -C sbc.cfg -m $(ROMIMG).map
CLIB = cc65.lib

HEXDUMP = hexdump
HEXDUMP_ARGS = -v -e '1/1 "%02x " "\n"'

# Compilation of assembler files
%.o: %.s
	$(CA65) $(CAFLAGS) -o $@ -l $(@:.o=.lst) $<

# Compilation of C files
%.o: %.c
	$(CC65) $(CCFLAGS) -o $(@:.o=.s) $<
	$(CA65) $(CAFLAGS) -o $@ -l $(@:.o=.lst) $(<:.c=.s)

# Default target
all: 	$(ASM_SOURCES:.s=.o) $(C_SOURCES:.c=.o)
	$(CL65) $(CLFLAGS) -o $(ROMIMG) $^ $(CLIB) 
	$(HEXDUMP) $(HEXDUMP_ARGS) $(ROMIMG) > $(ROMIMG).hex

# Remove all generated files
clean:
	rm -f $(ROMIMG) *.o *.lst *.map *.hex main.s


