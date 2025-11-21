# NOTE: Its been ages since I used Makefiles (I should rectify this)
# ChatGPT recommended it for this project, so I'm going to do it.
# This is based on example code provided by ChatGPT.

# Path variables
SRC		= ../../src/seq/seq.v
TB		= seq_tb.v
OUT		= build/mux_sim
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
