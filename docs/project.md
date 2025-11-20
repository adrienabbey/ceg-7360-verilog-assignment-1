# Verilog Assignment 1

> Adrien Abbey, November 2025

## Project Notes

- I'm running this primarily from my Windows 11 desktop with VSCode connected to Ubuntu 24.04 in WSL.
- Note that I'm heavily using ChatGPT for guidance as I learn these new tools.

### Tooling

- First I installed Icarus Verilog and GTKWave within Ubuntu with `sudo apt install iverilog gtkwave`
  - I verified the installs with `iverilog -v` and `gtkwave`
  - I wrote a `Makefile` (with ChatGPT's help) to compile, run, and then display the waveform output of the provided mux code.
    - Note: I needed to append instructions to the `mux_tb.v` code in order to instruct Icarus Verilog to generate a wave output file.
    - Now I can just navigate to the relevant `build` directory and run `make` to automatically compile and execute the simulation, then display the output waveform.
- For the second simulator, I decided to pivot back to Vivado on Windows.  
  - Originally I was inclined to try my luck with Verilator, but then I learned that I'd need to write test benches in C++, which I wasn't interested in writing.
  - Within Vivado, I created a new project and imported the original, unmodified Mux source files.
    - I needed to ensure that the `mux.v` file was the only design source, with the `mux_tb.v` file as the top simulation source.
    - Finally, I just needed to "Run Simulation" and ensure that my waveform and console outputs appeared accurate.
  - Note: the Vivado project files are NOT included in this repo.
  - Note: After taking screenshots, I reorganized the directory structure of the project.

### D-type Flip-Flop

- D-type flip-flops remember inputs, with their output being whatever the input was last remembered.
  - The output updates based on their clock input, typically the rising-edge, but only if enable is asserted.
  - Asserting reset will immediately set the output to zeros.
  - The output will change only if reset is asserted or on the rising clock edge if enable is asserted.
- I need to write a Verilog module for this DFF that does the following based on priority:
  - If reset is asserted at any time, clear the output.
  - On the clock's rising edge, if enable is asserted, set the output to the input and hold it.
- I'll be implementing this using behavioral logic (`always`, `if`, `else`, etc).
- My `always` list "should" include the rising clock edge, reset, and enable.
  - Because reset and enable are both asynchronous, they must be included.
  - However, I don't know how to add all three to the same list while only updating the output on clock.
  - Thus, I simply used two separate `always` blocks (one for reset, one for clock edge), and only update the output if reset isn't asserted.
    - This may be incorrect and need rectifying.  I sent an email to Bayley and am waiting to hear back regarding this.
- Because DFFs are clocked, I should use non-blocking assignments.
  - Failing to do this can lead to race conditions.

#### DFF Testbench

- I need to test reset, ensuring it's asynchronous and sets the output correctly.
- I need to test enable, ensuring the output only updates when enabled.
- I need to test clock, ensuring the output updates only on the rising edge.
- I need to test edge cases which are a mix of the above:
  - Asserting enable and reset at the same time on a rising clock edge.
  - Changing the input but not enable and ensuring the output doesn't change.
  - Ensuring the output doesn't change after a reset unless enable is asserted and reset is not.

### Sequence Detector

- I need to pick a 5-digit sequence to test for.
  - `12131`: some repetition and alternation with a surprise.
- I need to parameterize the data width, which I assume defines the symbol width.
  - Since the sequence is fixed, this doesn't do much, I assume.
- I need to select Moore or Mealy and pick a form of state encoding.
  - Moore, since it's sufficient and easier to implement.
  - I'll use binary encoding, as it's again sufficient and easier to implement.  Given 5 symbols + a start/reset state, I can use 3 bits to encode the state.
