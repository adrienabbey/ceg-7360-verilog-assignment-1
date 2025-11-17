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
--   WIDTH : Integer
--     Width of the D and Q buses
--
-- Ports:
--   clk      : Input
--   reset_n  : Input
--   enable_n : Input
--   d        : Input  [WIDTH-1:0]
--   q        : Output [WIDTH-1:0]
-------------------------------------------------------------------------------
*/
