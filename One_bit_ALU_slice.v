/*
    Title: 1 bit alu bit slice
    Input port:
        1. ctl: 功能選擇
        2. ai: 被加數
        3. bi: 加數
        4. invb: invert b (減法)
        5. cin: carry in
    Output port:
        1. sum: 結果
        2. carry: carry out
*/
`timescale 1ns/ 1ns
module One_bit_alu_slice(ctl, a, b, invb, cin, sum, carry);
    parameter AND = 6'b100100;
    parameter OR  = 6'b100101;
    parameter ADD = 6'b100000;
    parameter SUB = 6'b100010;
    parameter SLT = 6'b101010;

    parameter SRL = 6'b000010;

    parameter MULTU = 6'd25;
    parameter MFHI = 6'b010000;
    parameter MFLO = 6'b010010;

    input [5:0] ctl;
    input a, b, invb, cin;
    output sum, carry;

    wire temp0, temp1, temp2;
    // and
    and(temp0, a, b);

    // or
    or(temp1, a, b);

    // add
    wire e1;
    xor(e1, b, invb);
    Full_adder fa(.a(a), .b(e1), .cin(cin), .sum(temp2), .carry(carry));

    // assign sel
    wire [1:0] sel;
    assign sel = (ctl == MULTU) ? 2'b10:   // multu
                (ctl == AND) ? 2'b00:    // and
                (ctl == OR) ? 2'b01:    // or
                (ctl == ADD) ? 2'b10:    // add
                            2'b10;      // sub and slt

    // select
    Mux_4to1 mux41(.sel(sel), .in0(temp0), .in1(temp1), .in2(temp2), .in3(0), .out(sum));
endmodule