# Path variables
SRC		= ../../src/dff/dff.v
TB		= dff_tb.v
OUT		= build/dff_sim
WAVE	= waves.vcd

all: waves	# Running `make` from this directory will compile, run, and then open the output waveform.

# Step 1: Compile the Verilog code:
compile:
	mkdir -p build
	iverilog -o $(OUT) $(SRC) $(TB)

# Step 2: Run the simulation file:
run: compile
	vvp $(OUT)

# Step 3: Open the waveform:
waves: run
	gtkwave $(WAVE)

clean:
	rm -rf build $(WAVE)
