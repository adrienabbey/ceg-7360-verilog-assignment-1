// SPDX-License-Identifier: MIT
// Copyright (c) 2025 Adrien Abbey

/*
-------------------------------------------------------------------------------
-- Module Name: dff
-- Author:      Adrien Abbey
-- Date:        2025-11-17
-- Description:
--   Parameterizable D-type flip-flop with:
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

module dff #(  // The # means this is a parameterized module.
    parameter DATA_WIDTH = 8  // Default to 8 bits, can be changed.
) (
    input                       clk,       // Clock input
    input                       reset_n,   // Active-low reset input
    input                       enable_n,  // Active-low enable input
    input      [DATA_WIDTH-1:0] d,         // Input bus, adjusted to parameter size
    output reg [DATA_WIDTH-1:0] q          // Output bus as a register, adjusted to parameter size
);

  always @(negedge reset_n) begin  // As soon as reset is asserted...
    q <= 0;  // Reset the output to zero, non-blocking.
  end

  always @(posedge clk) begin  // On the rising clock edge...
    if (enable_n == 0 && reset_n == 1) begin  // If enable is asserted but reset is not...
      q <= d;  // Assign the input to the output, non-blocking.
    end
  end

endmodule
