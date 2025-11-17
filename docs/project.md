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
