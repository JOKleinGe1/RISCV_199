# Nom du design
TOP = riscv_199
TB  = tb_riscv

# Fichiers
SRC = riscv_199.v tb_riscv.v

# Sortie
OUT = sim.out

all: run

compile:
	iverilog -o $(OUT) $(SRC)

run: compile
	vvp $(OUT)

wave:
	gtkwave wave.vcd &

clean:
	rm -f *.out *.vcd
