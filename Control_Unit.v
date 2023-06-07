/*
         |     op    |   funct  | ALUop
    ----------------------------|-------
    add  |   000000  |  100000  |   10
    sub  |   000000  |  100010  |   10
    and  |   000000  |  100100  |   10    R
    or   |   000000  |  100101  |   10
    srl  |   000000  |  000010  |   10    T
    slt  |   000000  |  101010  |   10    y
    multu|   000000  |  011001  |   10    p
    maddu|   011100  |  000001  |   10    e
    mfhi |   000000  |  010000  |   10
    mflo |   000000  |  010010  |   10
    nop  |   000000  |  000000  |   10
    -----|-----------|----------|-------
    addiu|   001001  |  XXXXXX  |   00
    lw   |   100011  |  XXXXXX  |   00
    sw   |   101011  |  XXXXXX  |   00
    beq  |   000100  |  XXXXXX  |   01
    j    |   000010  |  XXXXXX  |   XX
*/
/*
            RegDst    ALUSrc     Maddu      ALUOp     HiorLo  HiLoWrite |   Branch    Jump      MemRead     MemWrite   |   RegWrite     MemtoReg     Shift       Mf 
    add        0        0          0         10         0         0     |     0         0          0           0       |       1            0          0          0
    sub        0        0          0         10         0         0     |     0         0          0           0       |       1            0          0          0
    and        0        0          0         10         0         0     |     0         0          0           0       |       1            0          0          0
    or         0        0          0         10         0         0     |     0         0          0           0       |       1            0          0          0
    srl        0        0          0         00         0         0     |     0         0          0           0       |       1            0          1          0
    slt        0        0          0         10         0         0     |     0         0          0           0       |       1            0          0          0
    multu      0        0          0         00         0         1     |     0         0          0           0       |       0            0          0          0
    maddu      0        0          1         00         0         1     |     0         0          0           0       |       0            0          0          0
    mfhi       0        0          0         00         1         0     |     0         0          0           0       |       1            0          0          1
    mflo       0        0          0         00         0         0     |     0         0          0           0       |       1            0          0          1
    nop        0        0          0         00         0         0     |     0         0          0           0       |       0            0          0          0
    addiu      1        1          0         00         0         0     |     0         0          0           0       |       1            0          0          0
    lw         1        1          0         00         0         0     |     0         0          1           0       |       1            1          0          0
    sw         0        1          0         00         0         0     |     0         0          0           1       |       0            0          0          0
    beq        0        0          0         01         0         0     |     1         0          0           0       |       0            0          0          0
    j          0        0          0         00         0         0     |     0         1          0           0       |       0            0          0          0
*/
/*
    Input :
        Op, Funct

    Output :

*/
`timescale 1ns/ 1ns
module Control_Unit(clk, rst, opcode, funct,
                   RegWrite, MemtoReg, Shift, Mf,
                   Branch, MemWrite, MemRead, Jump,
                   ALUSrc, HiorLo, RegDst, ALUOp);

    input wire clk, rst;
    input wire [5:0] opcode, funct;
    output reg RegWrite, MemtoReg, Shift, Mf,
               Branch, MemWrite, MemRead, Jump,
               ALUSrc, HiorLo, RegDst;
    output reg [1:0] ALUOp;

    // opcode
    parameter R_FORMAT = 6'd0;
    parameter LW = 6'd35;
    parameter SW = 6'd43;
    parameter BEQ = 6'd4;
	parameter J = 6'd2;
    parameter MADDU = 6'b011100;
    parameter ADDIU = 6'b001001;

    // funct
    parameter AND = 6'b100100;
    parameter OR  = 6'b100101;
    parameter ADD = 6'b100000;
    parameter SUB = 6'b100010;
    parameter SLT = 6'b101010;

    parameter SRL = 6'b000010;

    parameter MFHI = 6'b010000;
    parameter MFLO = 6'b010010;
    parameter MULTU = 6'b011001;

    parameter NOP = 6'b000000;

    always @(posedge clk or rst or funct or opcode) begin
        if (rst == 1) begin
            RegDst = 1'b0; ALUSrc = 1'b0; ALUOp = 2'b00; HiorLo = 1'b0;
            Branch = 1'b0; Jump = 1'b0; MemRead = 1'b0; MemWrite = 1'b0; RegWrite = 1'b0; MemtoReg = 1'b0;
            Shift = 1'b0; Mf = 1'b0;
        end
        else begin
            case (opcode)
                R_FORMAT : 
                begin
                    case (funct)
                        SRL:
                        begin
                            RegDst = 1'b0; ALUSrc = 1'b0; ALUOp = 2'b01; HiorLo = 1'b0;
                            Branch = 1'b0; Jump = 1'b0; MemRead = 1'b0; MemWrite = 1'b0; RegWrite = 1'b1; MemtoReg = 1'b0;
                            Shift = 1'b1; Mf = 1'b0;
                        end
                        MULTU:
                        begin
                            RegDst = 1'b0; ALUSrc = 1'b0; ALUOp = 2'b01; HiorLo = 1'b0;
                            Branch = 1'b0; Jump = 1'b0; MemRead = 1'b0; MemWrite = 1'b0; RegWrite = 1'b0; MemtoReg = 1'b0;
                            Shift = 1'b0; Mf = 1'b0;
                        end
                        MFHI:
                        begin
                            RegDst = 1'b0; ALUSrc = 1'b0; ALUOp = 2'b01; HiorLo = 1'b1;
                            Branch = 1'b0; Jump = 1'b0; MemRead = 1'b0; MemWrite = 1'b0; RegWrite = 1'b1; MemtoReg = 1'b0;
                            Shift = 1'b0; Mf = 1'b1;
                        end
                        MFLO:
                        begin
                            RegDst = 1'b0; ALUSrc = 1'b0; ALUOp = 2'b01; HiorLo = 1'b0;
                            Branch = 1'b0; Jump = 1'b0; MemRead = 1'b0; MemWrite = 1'b0; RegWrite = 1'b1; MemtoReg = 1'b0;
                            Shift = 1'b0; Mf = 1'b1;
                        end
                        NOP:
                        begin
                        end
                        default begin   // ADD SUB AND OR SLT
                            RegDst = 1'b0; ALUSrc = 1'b0; ALUOp = 2'b10; HiorLo = 1'b0;
                            Branch = 1'b0; Jump = 1'b0; MemRead = 1'b0; MemWrite = 1'b0; RegWrite = 1'b1; MemtoReg = 1'b0;
                            Shift = 1'b0; Mf = 1'b0;
                        end
                    endcase
                end
                ADDIU:
                begin
                    RegDst = 1'b1; ALUSrc = 1'b1; ALUOp = 2'b00; HiorLo = 1'b0;
                    Branch = 1'b0; Jump = 1'b0; MemRead = 1'b0; MemWrite = 1'b0; RegWrite = 1'b1; MemtoReg = 1'b0;
                    Shift = 1'b0; Mf = 1'b0;
                end
                MADDU:
                begin
                    RegDst = 1'b0; ALUSrc = 1'b0; ALUOp = 2'b01; HiorLo = 1'b0;
                    Branch = 1'b0; Jump = 1'b0; MemRead = 1'b0; MemWrite = 1'b0; RegWrite = 1'b0; MemtoReg = 1'b0;
                    Shift = 1'b0; Mf = 1'b0;
                end
                LW :
                begin
                    RegDst = 1'b1; ALUSrc = 1'b1; ALUOp = 2'b00; HiorLo = 1'b0;
                    Branch = 1'b0; Jump = 1'b0; MemRead = 1'b1; MemWrite = 1'b0; RegWrite = 1'b1; MemtoReg = 1'b1;
                    Shift = 1'b0; Mf = 1'b0;
                end
                SW :
                begin
                    RegDst = 1'b0; ALUSrc = 1'b1; ALUOp = 2'b00; HiorLo = 1'b0;
                    Branch = 1'b0; Jump = 1'b0; MemRead = 1'b0; MemWrite = 1'b1; RegWrite = 1'b0; MemtoReg = 1'b0;
                    Shift = 1'b0; Mf = 1'b0;
                end
                BEQ :
                begin
                    RegDst = 1'b0; ALUSrc = 1'b0; ALUOp = 2'b01; HiorLo = 1'b0;
                    Branch = 1'b1; Jump = 1'b0; MemRead = 1'b0; MemWrite = 1'b0; RegWrite = 1'b0; MemtoReg = 1'b0;
                    Shift = 1'b0; Mf = 1'b0;
                end
                J :
                begin
                    RegDst = 1'b0; ALUSrc = 1'b0; ALUOp = 2'b00; HiorLo = 1'b0;
                    Branch = 1'b0; Jump = 1'b1; MemRead = 1'b0; MemWrite = 1'b0; RegWrite = 1'b0; MemtoReg = 1'b0;
                    Shift = 1'b0; Mf = 1'b0;
                end
                default begin
                    $display("control_single unimplemented opcode %d", opcode);
                    RegDst = 1'b1; ALUSrc = 1'b1; ALUOp = 2'b01; HiorLo = 1'b1;
                    Branch = 1'b0; Jump = 1'b0; MemRead = 1'b0; MemWrite = 1'b0; RegWrite = 1'b0; MemtoReg = 1'b1;
                    Shift = 1'b1; Mf = 1'b1;
                end
            endcase
        end
    end
    

endmodule