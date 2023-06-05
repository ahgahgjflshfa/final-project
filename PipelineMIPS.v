`timescale 1ns/ 1ns
module PipelineMIPS(clk, rst);
    input wire clk, rst;

    // break out important fields from instruction

    // datapath signals

    // IF
    wire [31:0] pc, pc_incr_IF, instr_IF;

    // ID
    wire [63:0] HiLoConcat_ID;
    wire [31:0] pc_incr_ID, instr_ID, RD1_ID, RD2_ID, extend_immed_ID, HiOut_ID, LoOut_ID, HiLoData_ID;
    wire [25:0] j_offset_ID;
    wire [15:0] immed_ID;
    wire [5:0] op_ID, funct_ID;
    wire [4:0] rs_ID, rt_ID, rd_ID, shamt_ID;
    wire Mf_ID, Shift_ID, MemtoReg_ID, RegWrite_ID;     // w
    wire Branch_ID, MemWrite_ID, MemRead_ID, Jump_ID;   // m
    wire ALUOp_ID, ALUSrc_ID, HiorLo, RegDst_ID;     // e

    // EX
    wire [31:0] pc_incr_EX, RD1, RD2_EX, extend_immed_EX, j_address_EX, b_address_EX;
    wire [25:0] j_offset_EX;
    wire [5:0] funct_EX;
    wire [4:0] rs, rd, shamt;
    
    wire [63:0] HiLoConcat, MadduOUT, MULOut, DataForHiLo_EX;
    wire [31:0] ALUOut_EX, ShifterOut_EX, HiOut_EX, LoOut_EX, HiLoData_EX;
    wire [5:0] SignaltoMUL;
    wire [4:0] WN_EX;
    wire [2:0] SignaltoALU;
    wire Maddu, HiLoWrite_EX, Zero_EX;

    wire Mf_EX, Shift_EX, MemtoReg_EX, RegWrite_EX;
    wire Branch_EX, MemWrite_EX, MemRead_EX, Jump_EX;
    wire ALUOp, ALUSrc, RegDst;

    // MEM
    wire [63:0] DataForHiLo_MEM;
    wire [31:0] j_address_MEM, b_address_MEM, ShifterOut_MEM, ALUOut_MEM, RD2, HiLoData_MEM;
    wire [4:0] WN_MEM;
    wire Zero;

    wire [31:0] MemOut_MEM;
    wire PCSrc;     

    wire Mf_MEM, Shift_MEM, MemtoReg_MEM, RegWrite_MEM, HiLoWrite_MEM;
    wire Branch, MemWrite, MemRead, Jump;

    // WB
    wire [63:0] DataForHiLo;
    wire [31:0] ShifterOut, MemOut, ALUOut, DataForHilo, HiLoData;
    wire [4:0] WN;
    wire HiLoWrite;

    wire [31:0] WD1, WD2, WD, pc_next1, pc_next2, pc_next;

    wire MemtoReg, Shift, Mf, RegWrite;

    // module instantiations
    // IF
    reg32 PC(.clk(clk), .rst(rst), .en_reg(1'b1), .d_in(pc_next), .d_out(pc));

    add32 PCadd(.a(pc), .b(32'd4), .result(pc_incr_IF));

    memory InstrMem( .clk(clk), .MemRead(1'b1), .MemWrite(1'b0), .wd(32'd0), .addr(pc), .rd(instr_IF) );

    // IF/ID pipeline reg
    IFIDreg ifid(.clk(clk), .rst(rst), .PCincre_IN(pc_incr_IF),.instrIN(instr_IF), .PCincreOUT(pc_incr_ID), .instrOUT(instr_ID));

    // ID
    
endmodule 