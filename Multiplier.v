`timescale 1ns/1ns

module Multiplier(clk, rst, Signal, dataA, dataB, dataOut);
    input clk, rst;
    input [5:0] Signal;
    input [31:0] dataA, dataB;

    output [63:0] dataOut;

    reg [63:0] multiplicand; // 被乘數
    reg [31:0] multiplier; // 乘數
    reg [63:0] product;
    reg [63:0] tempOut;

    reg check;

    parameter MADDU = 6'b000001;
    parameter MULTU = 6'b011001;
    parameter OUT = 6'b111111;

    always @ (posedge clk or rst) begin
        if (rst == 1'b1)
            check = 1'b0;

        if (check == 1'b0 && (Signal == MULTU || Signal == MADDU)) begin
            multiplicand = {32'b0, dataA};
            multiplier = dataB;
            product = 64'b0;
            check = 1'b1;
        end

        if (multiplier[0] == 1'b1)
            product = product + multiplicand;

        if (Signal == MULTU || Signal == MADDU || check == 1'b1) begin
            multiplier = multiplier >> 1;
            multiplicand = multiplicand << 1;
        end

        if (Signal == OUT) begin
            tempOut = product;
            check = 1'b0;
        end
    end

    assign dataOut = (Signal == OUT) ? product : 0;
endmodule