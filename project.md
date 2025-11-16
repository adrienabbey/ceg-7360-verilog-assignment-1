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
