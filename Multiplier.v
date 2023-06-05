`timescale 1ns/1ns

module Multiplier(clk, reset, Signal, dataA, dataB, dataOut);
    input clk;
    input reset;
    input [5:0] Signal;
    input [31:0] dataA, dataB;

    output [63:0] dataOut;

    reg [63:0] multiplicand; // 被乘數
    reg [31:0] multiplier; // 乘數
    reg [63:0] product;
    reg [63:0] tempOut;

    parameter MADDU = 6'b000001;
    parameter MULTU = 6'b011001;
    parameter OUT = 6'b111111;

    always @ ( Signal == MULTU or Signal == MADDU )begin
        if (Signal == MULTU || Signal == MADDU) begin
            multiplicand = {32'b0, dataA};
            multiplier = dataB;
            product = 64'b0;
        end
    end

    always @ (posedge clk or reset) begin
        if (multiplier[0] == 1'b1)
            product = product + multiplicand;

        multiplier = multiplier >> 1;
        multiplicand = multiplicand << 1;

        if (Signal == OUT)
            tempOut = product;
    end

    assign dataOut = tempOut;
endmodule