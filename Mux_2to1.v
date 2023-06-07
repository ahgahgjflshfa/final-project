`timescale 1ns/ 1ns
module Mux_2to1(sel, in0, in1, out);
    input sel;
    input [32:0] in0, in1;
    output [32:0] out;

    assign out = sel ? in1 : in0;
endmodule