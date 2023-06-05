`timescale 1ns/1ns
module add32(a, b, result);
    input wire [63:0] a, b;
    output wire [63:0] result;

    assign result = a + b;
endmodule   