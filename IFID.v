`timescale 1ns/1ns
module IFIDreg(clk, rst, PCincreIN, instrIN, PCincreOUT, instrOUT);
    input wire clk, rst;
    input wire [31:0] PCincreIN, instrIN;
    output reg [31:0] PCincreOUT, instrOUT;

    always @(posedge clk or rst) begin
        if (rst) begin
            PCincreOUT <= 32'b0;
            instrOUT <= 32'b0;
        end
        else begin
            PCincreOUT <= PCincreIN;
            instrOUT <= instrIN;
        end
    end
endmodule