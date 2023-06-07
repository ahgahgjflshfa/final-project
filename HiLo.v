`timescale 1ns/1ns
module HiLo(clk, rst, en_reg, data_in, HiOut, LoOut);
    input clk, rst, en_reg;
    input wire [63:0] data_in;
    output [31:0] HiOut, LoOut;

    reg [63:0] HiLo; 

    always @(posedge clk or rst)
        if (rst == 1)
            HiLo <= 64'b0;
        
        else if (en_reg == 1)
            HiLo <= data_in;
    
    assign HiOut = HiLo[63:32];
    assign LoOut = HiLo[31:0];
endmodule