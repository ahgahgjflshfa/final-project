/*
    input:
        clk, rst

        W :
            MemtoReg, Shift, Mf
        
        ShifterData, MemData, ALUData, HiLoData, WN

    ouput:
        W, ShifterData, MemData, ALUData, HiLoData, WN
*/
`timescale 1ns/1ns
module MEMWBreg(clk, rst,
                RegWrite_IN, MemtoReg_IN, Shift_IN, Mf_IN, HiLoWrite_IN,
                ShifterData_IN, MemData_IN, ALUData_IN, MULData_IN, HiLoData_IN, WN_IN,
                RegWrite_OUT, MemtoReg_OUT, Shift_OUT, Mf_OUT, HiLoWrite_OUT,
                ShifterData_OUT, MemData_OUT, ALUData_OUT, MULData_OUT, HiLoData_OUT, WN_OUT);

    input wire clk, rst;
    input wire [63:0] MULData_IN;
    input wire [31:0] ShifterData_IN, MemData_IN, ALUData_IN, HiLoData_IN;
    input wire [4:0] WN_IN;
    input wire Mf_IN, Shift_IN, MemtoReg_IN, RegWrite_IN, HiLoWrite_IN;

    output reg [63:0] MULData_OUT;
    output reg [31:0] ShifterData_OUT, MemData_OUT, ALUData_OUT, HiLoData_OUT;
    output reg [4:0] WN_OUT;
    output reg Mf_OUT, Shift_OUT, MemtoReg_OUT, RegWrite_OUT, HiLoWrite_OUT;

    always @(posedge clk or rst) begin
        if (rst) begin
            ShifterData_OUT <= 0;
            MemData_OUT <= 0;
            ALUData_OUT <= 0;
            HiLoData_OUT <= 0;
            WN_OUT <= 0;
            Mf_OUT <= 0;
            Shift_OUT <= 0;
            MemtoReg_OUT <= 0;
            RegWrite_OUT <= 0;
            HiLoWrite_OUT <= 0;
            MULData_OUT <= 0;
        end
        else begin
            ShifterData_OUT <= ShifterData_IN;
            MemData_OUT <= MemData_IN;
            ALUData_OUT <= ALUData_IN;
            HiLoData_OUT <= HiLoData_IN;
            WN_OUT <= WN_IN;
            Mf_OUT <= Mf_IN;
            Shift_OUT <= Shift_IN;
            MemtoReg_OUT <= MemtoReg_IN;
            RegWrite_OUT <= RegWrite_IN;
            HiLoWrite_OUT <= HiLoWrite_IN;
            MULData_OUT <= MULData_IN;
        end
    end
endmodule