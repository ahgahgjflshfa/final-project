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
    beg        0        0          0         01         0         0     |     1         0          0           0       |       0            0          0          0
    j          0        0          0         00         0         0     |     0         1          0           0       |       0            0          0          0
*/

`timescale 1ns/1ns
module ALUControl( clk, funct, SignaltoALU, SignaltoMUL, Maddu, HiLoWrite );
    input clk ;
    input wire [5:0] funct ;
    output wire [5:0] SignaltoMUL;
    output reg [2:0] SignaltoALU;
    output reg Maddu, HiLoWrite;

    reg [5:0] temp ;
    reg [6:0] counter ;


    parameter AND = 6'b100100;
    parameter OR  = 6'b100101;
    parameter ADD = 6'b100000;
    parameter SUB = 6'b100010;
    parameter SLT = 6'b101010;

    parameter SRL = 6'b000010;

    parameter MFHI = 6'b010000;
    parameter MFLO = 6'b010010;
    parameter MULTU = 6'b011001;    // 25
    parameter MADDU = 6'b000001;

    parameter NOP = 6'b0;

    parameter ALU_add = 3'b010;
    parameter ALU_sub = 3'b110;
    parameter ALU_and = 3'b000;
    parameter ALU_or  = 3'b001;
    parameter ALU_slt = 3'b111;

    always @( posedge clk ) begin
        temp = funct ;

        if ( funct == MULTU ) begin
            counter = counter + 1 ;

            if ( counter == 32 ) begin
                HiLoWrite = 1'b1;
                Maddu = 1'b0;
                temp = 6'b111111 ;
                counter = 0 ;
            end
        end
        else if ( funct == MADDU) begin
            counter = counter + 1;

            if (counter == 32) begin
                HiLoWrite = 1'b1;
                Maddu = 1'b1;
                temp = 6'b111111;
                counter = 0;
            end
        end
        else
            counter = 0 ;

        case (funct)
            AND: SignaltoALU = ALU_and;
            OR: SignaltoALU = ALU_or;
            ADD: SignaltoALU = ALU_add;
            SUB: SignaltoALU = ALU_sub;
            SLT: SignaltoALU = ALU_slt;
            default begin
                SignaltoALU = ALU_and;
            end
        endcase
    end

    assign SignaltoMUL = temp ;

endmodule