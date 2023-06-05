/*
    input:
        clk, rst

        W :
            RegWrite, MemtoReg, Shift, Mf
        M :
            Branch, MemWrite, MemRead, Jump
        
        JumpAddress, BranchAddress, ShifterData, Zero, ALUData, RD2, DataForHiLo, HiLoData, WN

    ouput:
        W, M, JumpAddress, BranchAddress, ShifterData, Zero, ALUData, RD2, DataForHiLo, HiLoData, WN
*/
`timescale 1ns/1ns
module EXMEMreg(clk, rst, 
                RegWrite_IN, MemtoReg_IN, Shift_IN, Mf_IN, HiLoWrite_IN,
                Branch_IN, MemWrite_IN, MemRead_IN, Jump_IN,
                JumpAddress_IN, BranchAddress_IN, ShifterData_IN, Zero_IN, ALUData_IN, RD2_IN,
                DataForHiLo_IN, HiLoData_IN, WN_IN,
                RegWrite_OUT, MemtoReg_OUT, Shift_OUT, Mf_OUT, HiLoWrite_OUT,
                Branch_OUT, MemWrite_OUT, MemReadOUT, Jump_OUT,
                JumpAddress_OUT, BranchAddress_OUT, ShifterData_OUT, Zero_OUT, ALUData_OUT, RD2_OUT,
                DataForHiLo_OUT, HiLoData_OUT, WN_OUT);

    input wire clk, rst;
    input wire [63:0] DataForHiLo_IN;
    input wire [31:0] JumpAddress_IN, BranchAddress_IN, ShifterData_IN, ALUData_IN, RD2_IN, HiLoData_IN;
    input wire [4:0] WN_IN;
    input wire RegWrite_IN, MemtoReg_IN, Shift_IN, Mf_IN, HiLoWrite_IN,
                Branch_IN, MemWrite_IN, MemRead_IN, Jump_IN,
                Zero_IN;

    output reg [63:0] DataForHiLo_OUT;
    output reg [31:0] JumpAddress_OUT, BranchAddress_OUT, ShifterData_OUT, ALUData_OUT, RD2_OUT, HiLoData_OUT;
    output reg [4:0] WN_OUT;
    output reg RegWrite_OUT, MemtoReg_OUT, Shift_OUT, Mf_OUT, HiLoWrite_OUT,
                Branch_OUT, MemWrite_OUT, MemReadOUT, Jump_OUT,
                Zero_OUT;

    always @(posedge clk or rst) begin
        if (rst) begin
            DataForHiLo_OUT <= 0;
            JumpAddress_OUT <= 0;
            BranchAddress_OUT <= 0;
            ShifterData_OUT <= 0;
            ALUData_OUT <= 0;
            RD2_OUT <= 0;
            HiLoData_OUT <= 0;
            WN_OUT <= 0;
            RegWrite_OUT <= 0;
            MemtoReg_OUT <= 0;
            Shift_OUT   <= 0;
            Mf_OUT <= 0;
            Branch_OUT <= 0;
            MemWrite_OUT <= 0;
            MemReadOUT <= 0;
            Jump_OUT <= 0;
            Zero_OUT <= 0;
            HiLoWrite_OUT <= 0;
        end
        else begin
            DataForHiLo_OUT <= DataForHiLo_IN;
            JumpAddress_OUT <= JumpAddress_IN;
            BranchAddress_OUT <= Branch_IN;
            ShifterData_OUT <= ShifterData_IN;
            ALUData_OUT <= ALUData_IN;
            RD2_OUT <= RD2_IN;
            HiLoData_OUT <= HiLoData_IN;
            WN_OUT <= WN_IN;
            RegWrite_OUT <= RegWrite_IN;
            MemtoReg_OUT <= MemtoReg_IN;
            Shift_OUT   <= Shift_IN;
            Mf_OUT <= Mf_OUT;
            Branch_OUT <= Branch_IN;
            MemWrite_OUT <= MemWrite_IN;
            MemReadOUT <= MemRead_IN;
            Jump_OUT <= Jump_IN;
            Zero_OUT <= Zero_IN;
            HiLoWrite_OUT <= HiLoWrite_IN;
        end
    end
endmodule