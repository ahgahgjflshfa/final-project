`timescale 1ns/ 1ns
module PipelineMIPS(clk, rst);
    input wire clk, rst;

    // break out important fields from instruction

    // datapath signals

    // IF
    wire [31:0] pc, pc_incr_IF, instr_IF;

    // ID
    wire [31:0] pc_incr_ID, instr_ID, RD1_ID, RD2_ID, extend_immed_ID;
    wire [25:0] j_offset_ID;
    wire [15:0] immed_ID;
    wire [5:0] op_ID, funct_ID;
    wire [4:0] rs_ID, rt_ID, rd_ID, shamt_ID;
    wire Mf_ID, Shift_ID, MemtoReg_ID, RegWrite_ID;     // w
    wire Branch_ID, MemWrite_ID, MemRead_ID, Jump_ID;   // m
    wire ALUOp_ID, ALUSrc_ID, HiorLo_ID, RegDst_ID;     // e

    // EX
    wire [31:0] pc_incr_EX, RD1_EX, RD2_EX, extend_immed_EX, j_address_EX, b_address_EX;
    wire [25:0] j_offset_EX;
    wire [5:0] funct_EX;
    wire [4:0] rs_EX, rd_ex, shamt_EX;
    
    wire [63:0] MULOut, DataForHiLo_EX;
    wire [31:0] ALUOut, ShifterOut, HiOut, LoOut, HiLoData_EX;
    wire [5:0] SignaltoMUL;
    wire [4:0] WN_EX;
    wire [2:0] ALUCtrlSignal;
    wire Maddu, HiLoWrite, Zero_EX;

    wire Mf_EX, Shift_EX, MemtoReg_EX, RegWrite_EX;
    wire Branch_EX, MemWrite_EX, MemRead_EX, Jump_EX;
    wire ALUOp, ALUSrc, HiorLo, RegDst;

    // MEM
    wire [63:0] DataForHiLo;
    wire [31:0] j_address_MEM, b_address_MEM, ShifterOut_MEM, ALUOut_MEM, RD2_MEM, HiLoData_MEM;
    wire [4:0] WN_MEM;
    wire Zero;

    wire [31:0] MemOut_MEM;
    wire PCSrc;     

    wire Mf_MEM, Shift_MEM, MemtoReg_MEM, RegWrite_MEM;
    wire Branch, MemWrite, MemRead, Jump;
endmodule 