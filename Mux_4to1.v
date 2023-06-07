`timescale 1ns/ 1ns
module Mux_4to1(sel, in0, in1, in2, in3, out);
    input wire [1:0] sel;
    input in0, in1, in2, in3;
    output out;

    assign out = (sel == 2'b00) ? in0:
                (sel == 2'b01) ? in1:
                (sel == 2'b10) ? in2:
                                in3;
endmodule