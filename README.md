# Verilog Programming Assignment 1: HDL Hello World

> Fall 2025 Embedded Systems (CEG-7360-01)  
> Original files written and provided by Dr. Bayley King

## Using these Files

### Testbenches

- Open a terminal and navigate to the relevant `./sim/` directory (there's one for each of the different designs).
- Inside each of these directories is a `Makefile` that assumes that Icarus Verilog and GTKWave is installed.
- Running `make` within each of these directories will compile, simulate and then open the output waveform.

## Assignment Objectives

### Objective 1: Install and Configure HDL Simulation Tools (DONE)

- I'm going to focus on open source tooling, specifically Icarus Verilog and Verilator.

### Objective 2: Simulate the Provided 4-to-1 Multiplexer Design (DONE)

- I need to use both simulators to run the provided 4-1 MUX Verilog source file and its test bench.
- I need to verify that the simulation runs correctly and that the output waveform matches expected MUX behavior.
- I need to capture screenshots of the waveforms and the console/debug output for each simulator.

### Objective 3: Design a Parameterized D Flip-Flop Module (DONE)

- I need to write a standalone Verilog module that implements a clocked D-type Flip Flop with:
  - Reset (active-low, asynchronous assertion, and synchronous release)
  - Enable (active-low and asynchronous)
  - Parameterizable data width

### Objective 4: Develop a Testbench for the D Flip-Flop (DONE)

- This should thoroughly test the D-type flip-flop module, demonstrating correct behavior of:
  - Reset
  - Enable
  - Data capture on clock edges
- The testbench should produce terminal debug output and waveform traces suitable for screenshot documentation.

### Objective 5: Implement a Parameterized 5-Symbol Sequence Detector (DONE)

- Write a behavioral Verilog module implementing a detector for a 5-item input sequence (of my choice) with the following requirements:
  - Parameterizable input symbol width
  - Use of Moore or Mealy-style design (my choice)
  - Documentation of the chosen state-encoding method and justification for my choice
- This needs to be implemented at the behavioral level, not the gate level.

### Objective 6: Build a Comprehensive Testbench for the Sequence Detector (DONE)

- I need to create a robust testbench that verifies the correctness of the above detector with the following requirements:
  - Sufficient variety of test patterns
  - Monitors important internal registers/wires
  - Clear simulation output
  - Screenshots of the waveform and console outputs

### Objective 7: Write the Project Report (DONE)

- There should be a folder containing all the Verilog source files and testbenches
- This should be a PDF or Word document containing all my simulation results:
  - Screenshots from both simulators for the MUX
  - Screenshots of the D-type flip-flop
  - Screenshots of the sequence detector

## License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.
