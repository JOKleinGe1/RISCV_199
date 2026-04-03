CROSS_COMPILE ?= riscv32-linux-gnu-
CC      = $(CROSS_COMPILE)gcc
AS      = $(CROSS_COMPILE)gcc
OBJCOPY = $(CROSS_COMPILE)objcopy
OBJDUMP = $(CROSS_COMPILE)objdump

CFLAGS  = -march=rv32i -mabi=ilp32 -ffreestanding -fno-common 
LDFLAGS = -T link.ld -nostdlib -nostartfiles

SRCS_C  = 
SRCS_S  = progasm.s
OBJS    = $(SRCS_S:.S=.o) $(SRCS_C:.c=.o) 

ELF     = test.elf
DUMP    = test.dump

GENERATED =  $(ELF) $(BIN) $(DUMP)

.PHONY: all clean 

all: $(BIN) $(DUMP) $(MEM) $(MIF) 

$(ELF): $(SRCS_C) $(SRCS_S)
	@echo "1️⃣  Compilation 2️⃣  Edition de lien (linker) .s .c -> .elf"
	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-Map=$(MAP) -o $@ $^

$(DUMP): $(ELF)
	@echo "3️⃣ -B  Déassemblage de l'exécutable .elf -> .dump"
	$(OBJDUMP) -D $(ELF) > $(DUMP)

clean:
	@echo "🚮 Nettoyage des fichiers générés..."
	rm -f $(GENERATED) 
	
