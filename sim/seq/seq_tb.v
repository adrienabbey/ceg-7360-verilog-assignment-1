// SPDX-License-Identifier: MIT
// Copyright (c) 2025 Adrien Abbey

/*
-------------------------------------------------------------------------------
-- Module Name: seq_tb
-- Author:      Adrien Abbey
-- Date:        2025-11-20
-- Description:
--   Parameterizable sequence detector with the following features:
--    - Fixed 5-symbol sequence: 12131
--    - The symbol's data width is parameterizable
--    - Moore design with 3-bit binary state encoding
--
-- Parameters:
--   DATA_WIDTH : Integer
--     Width of the symbol data
--
-- Ports:
--   clk     : Input
--   reset_n : Input
--   in_symbol  : Input [DATA_WIDTH-1:0]
--   match   : Output
--
-- Devices Under Test:
--   state : Register [2:0]
--   next  : Register [2:0]
--
-- NOTES:
-- - Make steps 2 time units, as the clock changes every 1 time unit!
--   - The sequence detector expects the input to change every clock cycle.
-------------------------------------------------------------------------------
*/

`timescale 10ns / 1ns

module seq_tb;

  // Parameters:
  parameter DATA_WIDTH = 8;  // Sets the size of the symbol input bus; can be changed

  // Registers and wires:
  reg clk;  // Clock input.
  reg reset_n;  // Active-low reset input.
  reg [DATA_WIDTH-1:0] in_symbol;  // Symbol input bus, parameterized.
  reg [2:0] STATE, NEXT;  // DUT internal parameters tracking current and next states
  wire match;  // Match output signal.  This is a boolean.

  // Configure a sequence detector module for testing:
  seq #(  // Load my seq module
      .DATA_WIDTH(DATA_WIDTH)  // Match the testbench inputs/outputs
  ) seq0 (  // Create a new instance
      .clk(clk),  // Match the testbench inputs/outputs
      .reset_n(reset_n),
      .in_symbol(in_symbol),
      .match(match)
  );

  // Configure the clock:
  initial begin
    clk = 0;  // Start the clock low
    forever begin  // Run forever
      #1 clk = ~clk;  // Every 1 time step, invert the clock.
    end
  end

  // Testbench task list:
  initial begin
    // Configure the console signal monitor:
    $monitor("[%0t] reset_n=0x%0h in_symbol=0x%0h STATE=0x%0h NEXT=0x%0h match=0x%0h", $time,
             reset_n, in_symbol, seq0.state, seq0.next, match);

    // Initial signal setup:
    $display("Initial signal setup:");
    reset_n   = 1;  // Disable reset
    in_symbol = 0;  // Start with the input being zero.

    // Test a valid input sequence:
    $display("Testing valid input sequence:");
    #2 in_symbol = "1";  // Set the input symbol to the string of "1" and wait 2 time units.
    #2 in_symbol = "2";  // Set the second symbol and wait 2 time units.
    #2 in_symbol = "1";  // ...etc.
    #2 in_symbol = "3";
    #2 in_symbol = "1";  // Final sequence symbol
    #2;  // Let the result propagate

    // End the simulation:
    $finish;
  end

  // Export the wave file (needed for Icarus Verilog):
  initial begin
    $dumpfile("waves.vcd");  // Set the output file name
    $dumpvars(0, seq_tb);  // Include all signals
  end

endmodule
