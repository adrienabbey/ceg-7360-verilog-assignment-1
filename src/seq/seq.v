// SPDX-License-Identifier: MIT
// Copyright (c) 2025 Adrien Abbey

/*
-------------------------------------------------------------------------------
-- Module Name: seq
-- Author:      Adrien Abbey
-- Date:        2025-11-19
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
-------------------------------------------------------------------------------
*/

module seq #(
    parameter DATA_WIDTH = 4
) (
    input                       clk,        // Clock input
    input                       reset_n,    // Active-low reset input
    input      [DATA_WIDTH-1:0] in_symbol,  // Input bus, parameterized size
    output reg                  match       // Boolean match output, 1 if matched, 0 if not
);

  // Setup state parameters and registers:
  parameter [2:0] 
    START = 3'b000, 
    HAVE1 = 3'b001, 
    HAVE2 = 3'b010,
    HAVE3 = 3'b011,
    HAVE4 = 3'b100,
    HAVE5 = 3'b101;
  reg [2:0] state, next;

  // Adjust the states on the clock, or when reset is asserted:
  always @(posedge clk, negedge reset_n) begin
    if (!reset_n) begin  // If reset has been asserted...
      state <= START;  // ...go to the starting state.
    end else begin
      state <= next;  // Otherwise, shift to the next state.
    end
  end

  // Whenever the state or input changes:
  always @(state, in_symbol) begin
    next  = 3'bx;  // Failsafe: make the next state ambiguous.
    match = 1'b0;  // Failsafe: make the output non-matching.
    case (state)  // Check the current state.
      START: begin  // If we're at the starting state...
        if (in_symbol == "1") begin  // ...and the first symbol is "1"...
          next = HAVE1;  // ...then we have 1 symbol so far!
        end else begin
          next = START;  // ...otherwise, we are still in the start state.
        end
      end
      HAVE1: begin  // If we have one symbol...
        if (in_symbol == "1") begin  // ...and get that same symbol...
          next = HAVE1;  // ...then we still only have one symbol.
        end else if (in_symbol == "2") begin  // But if we get the next symbol...
          next = HAVE2;  // ...then we have two symbols!
        end else begin
          next = START;  // Otherwise, we go back to the start.
        end
      end
      HAVE2: begin  // I think the above said enough for commenting.
        if (in_symbol == "1") begin
          next = HAVE3;
        end else begin
          next = START;
        end
      end
      HAVE3: begin
        if (in_symbol == "1") begin
          next = HAVE1;
        end else if (in_symbol == "3") begin
          next = HAVE4;
        end else begin
          next = START;
        end
      end
      HAVE4: begin
        if (in_symbol == "1") begin
          next = HAVE5;
        end else begin
          next = START;
        end
      end
      HAVE5: begin
        match = 1'b1;  // Found a match!
        if (in_symbol == "1") begin
          next = HAVE1;
        end else if (in_symbol == "2") begin
          next = HAVE2;
        end else begin
          next = START;
        end
      end
    endcase
  end

endmodule
