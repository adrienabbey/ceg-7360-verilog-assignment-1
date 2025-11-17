/**************************************************************************************************
 * Copyright (c) 2025 Bayley King
 * Licensed under the MIT License
 **************************************************************************************************/
/*
 * Simple 4:1 MUX with enable and asynchronous reset test bench
 * Associated design file: mut.v
 * Developer: Bayley King
 */
`timescale 10ns/1ns

module tb_mux;

// parameter initialization
parameter DATA_WIDTH = 8;
// reg and wire initialization
reg [DATA_WIDTH:0] din_0;         // Input A
reg [DATA_WIDTH:0] din_1;         // Input B
reg [DATA_WIDTH:0] din_2;         // Input C
reg [DATA_WIDTH:0] din_3;         // Input D
reg [1:0] sel;                    // Select
reg reset_n;                      // Active low asynchronous reset
reg clk;                          // Clock input
wire [DATA_WIDTH:0] mux_out;   // Output Bus

// design initialization
mux #(
    .DATA_WIDTH(DATA_WIDTH)
) mux0 (
    .din_0(din_0),
    .din_1(din_1),
    .din_2(din_2),
    .din_3(din_3),
    .sel(sel),
    .reset_n(reset_n),
    .clk(clk),
    .mux_out(mux_out)
);

initial begin
    // will output to debugger, with any change to a value
    $monitor ("[%0t] sel=0x%0h din_0=0x%0h din_1=0x%0h din_2=0x%0h din_3=0x%0h mux_out=0x%0h", 
              $time, sel, din_0, din_1, din_2, din_3, mux_out
    );

    // test cases initializations
    $display("Test 1");
    reset_n = 1;
    sel = 0;
    din_0 = $random;
    din_1 = $random;
    din_2 = $random;
    din_3 = $random;

    // run through selects
    loop_sel();
    #5;

    // toggle reset
    $display("Reset Toggle");
    reset_n = 0;
    #15 reset_n = 1;


    $display("Test 2");
    // randomize, and run again with reset high
    din_0 = $random;
    din_1 = $random;
    din_2 = $random;
    din_3 = $random;
    loop_sel();
    #5; $finish;

end

// Task to run through all 4 select options
// Just speeds up checking all values in the output
task loop_sel;
    integer i;
    for (i = 0; i < 4; i = i + 1) begin
        sel = i; #5;
    end

endtask

// Clock running forever
initial begin
    clk = 0;
    forever begin
        #5 clk = ~clk;
    end
end

// NOTE: I added the following to enable output of the waveform:
initial begin
    $dumpfile("waves.vcd"); // Instructs the simulator to create the wave output file
    $dumpvars(0, tb_mux);   // Include all the signals in the testbench in the wave file
end

endmodule
