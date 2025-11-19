// SPDX-License-Identifier: MIT
// Copyright (c) 2025 Adrien Abbey

/*
-------------------------------------------------------------------------------
-- Module Name: dff_tb
-- Author:      Adrien Abbey
-- Date:        2025-11-17
-- Description:
--   Testbench for a Parameterizable D-type flip-flop with:
--     - Positive-edge clocking
--     - Active-low asynchronous reset
--       - This means that the moment reset goes low, the output clears 
--         immediately, regardless of clock, enable and data inputs
--     - Active-low asynchronous enable
--
-- Parameters:
--   DATA_WIDTH : Integer
--     Width of the D and Q buses
--
-- Ports:
--   clk      : Input
--   reset_n  : Input
--   enable_n : Input
--   d        : Input  [DATA_WIDTH-1:0]
--   q        : Output [DATA_WIDTH-1:0]
-------------------------------------------------------------------------------
*/

`timescale 10ns / 1ns

module dff_tb;

  // Parameters:
  parameter DATA_WIDTH = 16;  // Sets the size of the input/output buses; can be changed.

  // Registers and wires:
  reg clk;  // Clock input.  Inputs are registers as we want them to stick while testing.
  reg reset_n;  // Active-low reset input.
  reg enable_n;  // Active-low enable input.
  reg [DATA_WIDTH-1:0] d;  // Data input bus, parameterized.
  wire [DATA_WIDTH-1:0] q;  // Data output bus, parameterized.  This is a wire as it should constantly change.

  // Configure a DFF module for testing:
  dff #(  // Load my DFF module code
      .DATA_WIDTH(DATA_WIDTH)  // Set the DFF's data width parameter to match this testbench
  ) dff0 (  // Give a name to the new DFF instance
      .clk(clk),  // These lines simply tie the testbench registers/wires to the matching DFF inputs/outputs
      .reset_n(reset_n),
      .enable_n(enable_n),
      .d(d),
      .q(q)
  );

  // Configure the clock:
  initial begin
    clk = 0;  // Start the clock low
    forever begin  // Run forever
      #1 clk = ~clk;  // Every 5 time steps, invert the clock
    end
  end

  // Testing task list:
  initial begin
    // Monitor and display changes to the console:
    $monitor("[%0t] reset_n=0x%0h enable_n=0x%0h d=0x%0h q=0x%0h", $time, reset_n, enable_n, d, q);

    // Initial signal setup:
    $display("Initial signal setup:");
    reset_n = 1;  // Disable reset
    enable_n = 0;  // Assert enable
    d = $random;  // Set a random input
    #5;  // Wait 5 time units

    // Test enable:
    $display("Testing enable:");
    enable_n = 1;  // Disable enable
    #5;  // Wait 5 units
    d = $random;  // Set a random input
    #5;  // Wait 5 units
    enable_n = 0;  // Assert enable
    #5;  // Wait 5 units

    // Test reset:
    $display("Testing reset:");
    reset_n = 0;  // Assert reset
    #5;  // Wait 5 units
    d = $random;  // Set a random input
    #5;  // Wait 5 units
    reset_n = 1;  // Disable reset
    #5;  // Wait 5 units

    // End the simulation:
    $finish;
  end

  // Export the wave file (needed for Icarus Verilog):
  initial begin
    $dumpfile("waves.vcd");  // Set the file name
    $dumpvars(0, dff_tb);  // Include all the signals
  end

endmodule
