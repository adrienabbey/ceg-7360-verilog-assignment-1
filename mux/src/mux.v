/**************************************************************************************************
 * Copyright (c) 2025 Bayley King
 * Licensed under the MIT License
 **************************************************************************************************/
/*
 * Simple 4:1 MUX with enable and asynchronus reset
 * Associated test bench file: mut_tb.v
 * Developer: Bayley King
 */

module mux #(
    parameter DATA_WIDTH = 8
)(
    input [DATA_WIDTH:0] din_0,         // Input A
    input [DATA_WIDTH:0] din_1,         // Input B
    input [DATA_WIDTH:0] din_2,         // Input C
    input [DATA_WIDTH:0] din_3,         // Input D
    input [1:0] sel,                    // Select
    input reset_n,                      // Active low asynchronus reset
    input clk,                          // Clock input
    output reg [DATA_WIDTH:0] mux_out   // Output Bus
);

always @ (posedge clk, negedge reset_n, sel) begin
    if (reset_n == 0) begin
        mux_out = 0;
    end
    else begin
        case (sel)
            2'b00 : mux_out = din_0;
            2'b01 : mux_out = din_1;
            2'b10 : mux_out = din_2;
            2'b11 : mux_out = din_3;
        endcase
    end
end
endmodule
