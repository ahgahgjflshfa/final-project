`timescale 1ns/ 1ns
module PipelineMIPS(clk, rst);
    input wire clk, rst;

// IF
    wire [31:0] pc, pc_incr_IF, instr_IF;

// ID
    wire [31:0] pc_incr_ID, instr_ID, RD1_ID, RD2_ID, extend_immed_ID, HiOut, LoOut, HiLoData_ID;
    wire [25:0] j_offset_ID;
    wire [15:0] immed;
    wire [5:0] op, funct_ID;
    wire [4:0] rs, rt_ID, rd_ID, shamt_ID;
    wire Mf_ID, Shift_ID, MemtoReg_ID, RegWrite_ID;     // w
    wire Branch_ID, MemWrite_ID, MemRead_ID, Jump_ID;   // m
    wire ALUOp_ID, ALUSrc_ID, HiorLo, RegDst_ID;     // e

// EX
    wire [31:0] pc_incr_EX, RD1, RD2_EX, extend_immed, j_address_EX, b_address_EX;
    wire [25:0] j_offset;
    wire [5:0] funct;
    wire [4:0] rt, rd, shamt;
    
    wire [63:0] HiLoConcat, MadduOut, MULOut, DataForHiLo_EX;
    wire [31:0] ALUOut_EX, ShifterOut_EX, HiLoData_EX, ALU_Input2;
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

    wire [31:0] MemOut_MEM, pc_next1, pc_next;
    wire PCSrc;     

    wire Mf_MEM, Shift_MEM, MemtoReg_MEM, RegWrite_MEM, HiLoWrite_MEM;
    wire Branch, MemWrite, MemRead, Jump;

// WB
    wire [63:0] DataForHiLo;
    wire [31:0] ShifterOut, MemOut, ALUOut, DataForHilo, HiLoData;
    wire [4:0] WN;
    wire HiLoWrite;

    wire [31:0] WD1, WD2, WD;

    wire MemtoReg, Shift, Mf, RegWrite;

    // module instantiations

// IF
    reg32 PC(.clk(clk), .rst(rst), .en_reg(1'b1), .d_in(pc_next), .d_out(pc));

    add32 PCadd(.a(pc), .b(32'd4), .result(pc_incr_IF));

    memory InstrMem( .clk(clk), .MemRead(1'b1), .MemWrite(1'b0), .wd(32'd0), .addr(pc), .rd(instr_IF) );

// IF/ID pipeline reg
    IFIDreg ifid(.clk(clk), .rst(rst), .PCincre_IN(pc_incr_IF),.instrIN(instr_IF), .PCincreOUT(pc_incr_ID), .instrOUT(instr_ID));

// ID
    assign op = instr_ID[31:26];
    assign funct_ID = instr_ID[5:0];
    assign shamt_ID = instr_ID[10:6];
    assign rs = instr_ID[25:21];
    assign rt_ID = instr_ID[20:16];
    assign rd_ID = instr_ID[15:11];
    assign immed = instr_ID[15:0];

    reg_file RegFile(.clk(clk), .RegWrite(RegWrite), .RN1(rs), .RN2(rt_ID), .WN(WN), .WD(WD), .RD1(RD1_ID), .RD2(RD2_ID));

    Control_Unit control(.opcode(op), .funct(funct_ID), .RegWrite(RegWrite_ID), .MemtoReg(MemtoReg_ID),
                        .Shift(Shift_ID), .Mf(Mf_ID), .Branch(Branch_ID), .MemWrite(MemWrite_ID),
                        .MemRead(MemRead_ID), .Jump(Jump_ID), .ALUSrc(ALUSrc_ID), .HiorLo(HiorLo),
                        .RegDst(RegDst_ID), .ALUOp(ALUOp_ID));

    Sign_Extend extnd(.immed_in(immed), .ext_immed_out(extend_immed_ID));

    HiLo hilo(.clk(clk), .rst(rst), .en_reg(HiLoWrite), .data_in(DataForHiLo), .HiOut(HiOut), .LoOut(LoOut));

    Mux2_32bit HiLoMUX(.sel(HiorLo), .in0(HiOut), .in1(LoOut), .out(HiLoData_ID));

// ID/EX pipeline reg
    IDEXreg idex(.clk(clk), .rst(rst), .RegWrite_IN(RegWrite_ID), .MemtoReg_IN(MemtoReg_ID), .Shift_IN(Shift_ID),
                .Mf_IN(Mf_ID), .Branch_IN(Branch_ID), .MemWrite_IN(MemWrite_ID), .MemRead_IN(MemRead_ID),
                .Jump_IN(Jump_ID), .ALUSrc_IN(ALUSrc_ID), .RegDst_IN(RegDst_ID), .ALUOp_IN(ALUOp_ID), .funct_IN(funct_ID),
                .instr_index_IN(j_offset_ID), .PCincre_IN(pc_incr_ID), .shamt_IN(shamt_ID), .RD1_IN(RD1_ID), .RD2_IN(RD2_ID),
                .ext_immed_IN(extend_immed_ID), .rt_IN(rt_ID), .rd_IN(rd_ID), .HiLoData_IN(HiLoData_ID),
                .HiLoConcat_IN({HiOut, LoOut}), .RegWrite_OUT(RegWrite_EX), .MemtoReg_OUT(MemtoReg_EX), .Shift_OUT(Shift_EX),
                .Mf_OUT(Mf_EX), .Branch_OUT(Branch_EX), .MemWrite_OUT(MemWrite_EX), .MemRead_OUT(MemRead_EX),
                .Jump_OUT(Jump_EX), .ALUSrc_OUT(ALUSrc), .RegDst_OUT(RegDst), .ALUOp_OUT(ALUOp), .funct_OUT(funct),
                .instr_index_OUT(j_offset), .PCincre_OUT(pc_incr_EX), .shamt_OUT(shamt), .RD1_OUT(RD1), .RD2_OUT(RD2_EX),
                .ext_immed_OUT(extend_immed), .rt_OUT(rt), .rd_OUT(rd), .HiLoData_OUT(HiLoData_EX), .HiLoConcat_OUT(HiLoConcat));

// EX
    add32 BranchADD(.a(pc_incr_EX), .b(extend_immed << 2), .result(b_address_EX));

    ALUControl aluctrl(.clk(clk), .funct(funct), .SignaltoALU(SignaltoALU), .SignaltoMUL(SignaltoMUL), 
                        .Maddu(Maddu), .HiLoWrite(HiLoWrite_EX));

    Shifter shifter(.a(RD2_EX), .shamt(shamt), .result(ShifterOut_EX));

    Multiplier mul(.clk(clk), .Signal(SignaltoMUL), .dataA(RD1), .dataB(RD2_EX), .dataOut(MULOut));

    Mux2_32bit alusrcMUX(.sel(ALUSrc), .in0(RD2_EX), .in1(extend_immed), .out(ALU_Input2));

    ALU alu(.ctl(SignaltoALU), .a(RD1), .b(ALU_Input2), .cin(0), .carry(), .result(ALUOut), .zero(Zero_EX));

    add64 madduADD(.a(MULOut), .b(HiLoConcat), .result(MadduOut));

    Mux2_5bit WNMUX(.sel(RegDst), .in0(rd), .in1(rt), .out(WN_EX));

    Mux2_64bit MadduMUX(.sel(Maddu), .in0(MULOut), .in1(MadduOut), .out(DataForHiLo_EX));

// EX/MEM pipeline reg
    EXMEMreg exmem(.clk(clk), .rst(rst), .RegWrite_IN(RegWrite_EX), .MemtoReg_IN(MemtoReg_EX), .Shift_IN(Shift_EX),
                .Mf_IN(Mf_EX), .HiLoWrite_IN(HiLoWrite_EX), .Branch_IN(Branch_EX), .MemWrite_IN(MemWrite_EX),
                .MemRead_IN(MemRead_EX), .Jump_IN(Jump_EX), .JumpAddress_IN(j_address_EX), 
                .BranchAddress_IN(b_address_EX), .ShifterData_IN(ShifterOut_EX), .Zero_IN(Zero_EX),
                .ALUData_IN(ALUOut_EX), .RD2_IN(RD2_EX), .DataForHilo_IN(DataForHiLo_EX), .HiLoData_IN(HiLoData_EX),
                .WN_IN(WN_EX), .RegWrite_OUT(RegWrite_MEM), .MemtoReg_OUT(MemtoReg_MEM), .Shift_OUT(Shift_MEM),
                .Mf_OUT(Mf_MEM), .HiLoWrite_OUT(HiLoWrite_MEM), .Branch_OUT(Branch), .MemWrite_OUT(MemWrite),
                .MemRead_OUT(MemRead), .Jump_OUT(Jump), .JumpAddress_OUT(j_address_MEM), 
                .BranchAddress_OUT(b_address_MEM), .ShifterData_OUT(ShifterOut_MEM), .Zero_OUT(Zero), 
                .ALUData_OUT(ALUOut_MEM), .RD2_OUT(RD2), .DataForHiLo_OUT(DataForHiLo_MEM), .HiLoData_OUT(HiLoData_MEM),
                .WN_OUT(WN_MEM));

// MEM
    and BranchAND(PCSrc, Branch, Zero);

    memory DataMemory(.clk(clk), .MemRead(MemRead), .MemWrite(MemWrite), .wd(RD2), .addr(ALUOut_MEM));

    Mux2_32bit BranchMUX(.sel(PCSrc), .in0(pc_incr_IF), .in1(b_address_MEM), .out(pc_next1));

    Mux2_32bit JumpMUX(.sel(Jump), .in0(pc_next1), .in1(j_address_MEM), .out(pc_next));

// MEM/WB pipeline reg
     MEMWBreg memwb(.clk(clk), .rst(rst), .RegWrite_IN(RegWrite_MEM), .MemtoReg(MemtoReg_MEM), .Shift_IN(Shift_MEM), .Mf_IN(Mf_MEM),
                    .HiLoWrite_IN(HiLoWrite_MEM), .ShifterData_IN(ShifterOut_MEM), .MemData_IN(MemOut_MEM), .ALUData_IN(ALUOut_MEM),
                    .DataForHilo_IN(DataForHiLo_MEM), .HiLoData_IN(HiLoData_MEM), .WN_IN(WN_MEM), .RegWrite_OUT(RegWrite_MEM),
                    .MemtoReg_OUT(MemtoReg), .Shift_OUT(Shift), .Mf_OUT(Mf), .HiLoWrite_OUT(HiLoWrite), .ShifterData_OUT(ShifterOut),
                    .MemData_OUT(MemOut), .ALUData_OUT(ALUOut), .DataForHiLo_OUT(DataForHilo), .HiLoData_OUT(HiLoData), .WN_OUT(WN));

// WB
    Mux2_32bit MemMUX(.sel(MemtoReg), .in0(ALUOut), .in1(MemOut), .out(WD1));

    Mux2_32bit ShiftMUX(.sel(Shift), .in0(WD1), .in1(ShifterOut), .out(WD2));

    Mux2_32bit MfMUX(.sel(Mf), .in0(WD2), .in1(HiLoData), .out(WD));

endmodule 