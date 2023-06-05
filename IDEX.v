/*
    input:
        clk, rst

        W :
            RegWrite, MemtoReg, Shift, Mf
        M :
            Branch, HiLoWrite, MemWrite, MemRead, Jump
        E :
            ALUSrc, HiorLo, RegDst, Maddu, ALUOp
        
        instr_index, PCincre, shamt, RD1, RD2, ext_immed, rt, rd, funct, HiLoData, HiLoConcat

    ouput:
        W, M, E, instr_index, PCincre, shamt, RD1, RD2, ext_immed, rt, rd, funct, HiLoData, HiLoConcat
*/

`timescale 1ns/1ns
module IDEXreg(clk, rst, 
                RegWrite_IN, MemtoReg_IN, Shift_IN, Mf_IN,
                Branch_IN, MemWrite_IN, MemRead_IN, Jump_IN,
                ALUSrc_IN, RegDst_IN, ALUOp_IN, funct_IN,
                instr_index_IN, PCincre_IN, shamt_IN, RD1_IN, RD2_IN, ext_immed_IN, rt_IN, rd_IN, HiLoData_IN, HiLoConcat_IN, 
                RegWrite_OUT, MemtoReg_OUT, Shift_OUT, Mf_OUT,
                Branch_OUT, MemWrite_OUT, MemReadOUT, Jump_OUT,
                ALUSrc_OUT, RegDst_OUT, ALUOp_OUT, funct_OUT,
                instr_index_OUT, PCincre_OUT, shamt_OUT, RD1_OUT, RD2_OUT, ext_immed_OUT, rt_OUT, rd_OUT, HiLoData_OUT, HiLoConcat_OUT);

    input wire clk, rst;
    input wire [63:0] HiLoConcat_IN;
    input wire [31:0] PCincre_IN, RD1_IN, RD2_IN, ext_immed_IN, HiLoData_IN;
    input wire [25:0] instr_index_IN;
    input wire [5:0] funct_IN;
    input wire [4:0] shamt_IN, rt_IN, rd_IN;
    input wire [1:0] ALUOp_IN;
    input wire RegWrite_IN, MemtoReg_IN, Shift_IN, Mf_IN,
                Branch_IN, MemWrite_IN, MemRead_IN, Jump_IN,
                ALUSrc_IN, RegDst_IN;

    output reg [63:0] HiLoConcat_OUT;
    output reg [31:0] PCincre_OUT, RD1_OUT, RD2_OUT, ext_immed_OUT, HiLoData_OUT;
    output reg [25:0] instr_index_OUT;
    output reg [5:0] funct_OUT;
    output reg [4:0] shamt_OUT, rt_OUT, rd_OUT;
    output reg [1:0] ALUOp_OUT;
    output reg RegWrite_OUT, MemtoReg_OUT, Shift_OUT, Mf_OUT,
                Branch_OUT, MemWrite_OUT, MemReadOUT, Jump_OUT,
                ALUSrc_OUT, RegDst_OUT;

    always @(posedge clk or rst) begin
        if (rst) begin
            ALUOp_OUT <= 0;
            RegWrite_OUT <= 0;
            MemtoReg_OUT <= 0;
            Shift_OUT   <= 0;
            Mf_OUT <= 0;
            Branch_OUT <= 0;
            MemWrite_OUT <= 0;
            MemReadOUT <= 0;
            Jump_OUT <= 0;
            ALUSrc_OUT <= 0;
            RegDst_OUT <= 0;
            instr_index_OUT <= 0;
            PCincre_OUT <= 0;
            shamt_OUT <= 0;
            RD1_OUT <= 0;
            RD2_OUT <= 0;
            ext_immed_OUT <= 0;
            rt_OUT <= 0;
            rd_OUT <= 0;
            funct_OUT <= 0;
            HiLoData_OUT <= 0;
            HiLoConcat_OUT <= 0;
        end
        else begin
            ALUOp_OUT <= ALUOp_IN;
            RegWrite_OUT <= RegWrite_IN;
            MemtoReg_OUT <= MemtoReg_IN;
            Shift_OUT   <= Shift_IN;
            Mf_OUT <= Mf_OUT;
            Branch_OUT <= Branch_IN;
            MemWrite_OUT <= MemWrite_IN;
            MemReadOUT <= MemRead_IN;
            Jump_OUT <= Jump_IN;
            ALUSrc_OUT <= ALUSrc_IN;
            RegDst_OUT <= RegDst_IN;
            instr_index_OUT <= instr_index_IN;
            PCincre_OUT <= PCincre_IN;
            shamt_OUT <= shamt_IN;
            RD1_OUT <= RD1_IN;
            RD2_OUT <= RD2_IN;
            ext_immed_OUT <= ext_immed_IN;
            rt_OUT <= rt_IN;
            rd_OUT <= rd_IN;
            funct_OUT <= funct_IN;
            HiLoData_OUT <= HiLoData_IN;
            HiLoConcat_OUT <= HiLoConcat_IN;
        end
    end
endmodule