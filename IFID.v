`timescale 1ns/1ns
module IFIDreg(clk, rst, PCincre_IN, instr_IN, PCincre_OUT, instr_OUT);
    input wire clk, rst;
    input wire [31:0] PCincre_IN, instr_IN;
    output reg [31:0] PCincre_OUT, instr_OUT;

    always @(posedge clk or rst) begin
        if (rst) begin
            PCincre_OUT <= 32'b0;
            instr_OUT <= 32'b0;
        end
        else begin
            PCincre_OUT <= PCincre_IN;
            instr_OUT <= instr_IN;
        end
    end
endmodule