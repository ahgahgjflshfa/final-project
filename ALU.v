/*
    Title: ALU
    Input Port
		1. ctl: 由alu_ctl解碼完的控制訊號
		2. a:   inputA,第一筆要處理的資料
		3. b:   inputB,第二筆要處理的資料
	Output Port
		1. result: 最後處理完的結果
		2. zero:   branch指令所需要之輸出
*/
`timescale 1ns/ 1ns
module ALU(ctl, a, b, cin, carry, result, zero);
    parameter AND = 6'b100100;
    parameter OR  = 6'b100101;
    parameter ADD = 6'b100000;
    parameter SUB = 6'b100010;
    parameter SLT = 6'b101010;

    parameter SRL = 6'b000010;

    parameter MULTU = 6'd25;
    parameter MFHI = 6'b010000;
    parameter MFLO = 6'b010010;

    input cin;
    input [5:0] ctl;
    input [31:0] a, b;
    output wire [31:0] result;
    output carry, zero;

    wire inv, c;
    assign inv = (ctl == SUB) ? 1'b1:   // sub
                 (ctl == SLT) ? 1'b1:   // slt
                               1'b0;   // other

    assign c = (ctl == SUB) ? 1'b1:  // sub
                (ctl == SLT) ? 1'b1:   // slt
                            cin;      // cin

    wire [31:0] sum, cout;

    One_bit_alu_slice aluslice0(.ctl(ctl), .a(a[0]), .b(b[0]), .invb(inv), .cin(c), .sum(sum[0]), .carry(cout[0]));
    One_bit_alu_slice aluslice1(.ctl(ctl), .a(a[1]), .b(b[1]), .invb(inv), .cin(cout[0]), .sum(sum[1]), .carry(cout[1]));
    One_bit_alu_slice aluslice2(.ctl(ctl), .a(a[2]), .b(b[2]), .invb(inv), .cin(cout[1]), .sum(sum[2]), .carry(cout[2]));
    One_bit_alu_slice aluslice3(.ctl(ctl), .a(a[3]), .b(b[3]), .invb(inv), .cin(cout[2]), .sum(sum[3]), .carry(cout[3]));
    One_bit_alu_slice aluslice4(.ctl(ctl), .a(a[4]), .b(b[4]), .invb(inv), .cin(cout[3]), .sum(sum[4]), .carry(cout[4]));
    One_bit_alu_slice aluslice5(.ctl(ctl), .a(a[5]), .b(b[5]), .invb(inv), .cin(cout[4]), .sum(sum[5]), .carry(cout[5]));
    One_bit_alu_slice aluslice6(.ctl(ctl), .a(a[6]), .b(b[6]), .invb(inv), .cin(cout[5]), .sum(sum[6]), .carry(cout[6]));
    One_bit_alu_slice aluslice7(.ctl(ctl), .a(a[7]), .b(b[7]), .invb(inv), .cin(cout[6]), .sum(sum[7]), .carry(cout[7]));
    One_bit_alu_slice aluslice8(.ctl(ctl), .a(a[8]), .b(b[8]), .invb(inv), .cin(cout[7]), .sum(sum[8]), .carry(cout[8]));
    One_bit_alu_slice aluslice9(.ctl(ctl), .a(a[9]), .b(b[9]), .invb(inv), .cin(cout[8]), .sum(sum[9]), .carry(cout[9]));
    One_bit_alu_slice aluslice10(.ctl(ctl), .a(a[10]), .b(b[10]), .invb(inv), .cin(cout[9]), .sum(sum[10]), .carry(cout[10]));
    One_bit_alu_slice aluslice11(.ctl(ctl), .a(a[11]), .b(b[11]), .invb(inv), .cin(cout[10]), .sum(sum[11]), .carry(cout[11]));
    One_bit_alu_slice aluslice12(.ctl(ctl), .a(a[12]), .b(b[12]), .invb(inv), .cin(cout[11]), .sum(sum[12]), .carry(cout[12]));
    One_bit_alu_slice aluslice13(.ctl(ctl), .a(a[13]), .b(b[13]), .invb(inv), .cin(cout[12]), .sum(sum[13]), .carry(cout[13]));
    One_bit_alu_slice aluslice14(.ctl(ctl), .a(a[14]), .b(b[14]), .invb(inv), .cin(cout[13]), .sum(sum[14]), .carry(cout[14]));
    One_bit_alu_slice aluslice15(.ctl(ctl), .a(a[15]), .b(b[15]), .invb(inv), .cin(cout[14]), .sum(sum[15]), .carry(cout[15]));
    One_bit_alu_slice aluslice16(.ctl(ctl), .a(a[16]), .b(b[16]), .invb(inv), .cin(cout[15]), .sum(sum[16]), .carry(cout[16]));
    One_bit_alu_slice aluslice17(.ctl(ctl), .a(a[17]), .b(b[17]), .invb(inv), .cin(cout[16]), .sum(sum[17]), .carry(cout[17]));
    One_bit_alu_slice aluslice18(.ctl(ctl), .a(a[18]), .b(b[18]), .invb(inv), .cin(cout[17]), .sum(sum[18]), .carry(cout[18]));
    One_bit_alu_slice aluslice19(.ctl(ctl), .a(a[19]), .b(b[19]), .invb(inv), .cin(cout[18]), .sum(sum[19]), .carry(cout[19]));
    One_bit_alu_slice aluslice20(.ctl(ctl), .a(a[20]), .b(b[20]), .invb(inv), .cin(cout[19]), .sum(sum[20]), .carry(cout[20]));
    One_bit_alu_slice aluslice21(.ctl(ctl), .a(a[21]), .b(b[21]), .invb(inv), .cin(cout[20]), .sum(sum[21]), .carry(cout[21]));
    One_bit_alu_slice aluslice22(.ctl(ctl), .a(a[22]), .b(b[22]), .invb(inv), .cin(cout[21]), .sum(sum[22]), .carry(cout[22]));
    One_bit_alu_slice aluslice23(.ctl(ctl), .a(a[23]), .b(b[23]), .invb(inv), .cin(cout[22]), .sum(sum[23]), .carry(cout[23]));
    One_bit_alu_slice aluslice24(.ctl(ctl), .a(a[24]), .b(b[24]), .invb(inv), .cin(cout[23]), .sum(sum[24]), .carry(cout[24]));
    One_bit_alu_slice aluslice25(.ctl(ctl), .a(a[25]), .b(b[25]), .invb(inv), .cin(cout[24]), .sum(sum[25]), .carry(cout[25]));
    One_bit_alu_slice aluslice26(.ctl(ctl), .a(a[26]), .b(b[26]), .invb(inv), .cin(cout[25]), .sum(sum[26]), .carry(cout[26]));
    One_bit_alu_slice aluslice27(.ctl(ctl), .a(a[27]), .b(b[27]), .invb(inv), .cin(cout[26]), .sum(sum[27]), .carry(cout[27]));
    One_bit_alu_slice aluslice28(.ctl(ctl), .a(a[28]), .b(b[28]), .invb(inv), .cin(cout[27]), .sum(sum[28]), .carry(cout[28]));
    One_bit_alu_slice aluslice29(.ctl(ctl), .a(a[29]), .b(b[29]), .invb(inv), .cin(cout[28]), .sum(sum[29]), .carry(cout[29]));
    One_bit_alu_slice aluslice30(.ctl(ctl), .a(a[30]), .b(b[30]), .invb(inv), .cin(cout[29]), .sum(sum[30]), .carry(cout[30]));
    One_bit_alu_slice aluslice31(.ctl(ctl), .a(a[31]), .b(b[31]), .invb(inv), .cin(cout[30]), .sum(sum[31]), .carry(cout[31]));

    assign result = (ctl == SLT) ? {31'b0, sum[31]}: // slt
                                  sum;              // other

    assign carry = (ctl == SLT) ? 1'b0:
                                cout[31];

    assign zero = (sum == 32'b0) ? 1 : 0;
endmodule