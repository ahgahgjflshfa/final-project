`timescale 1ns/ 1ns
module Full_adder(a, b, cin, carry, sum);

    input wire a, b, cin;
    output wire carry, sum;
    
    wire s, c;
    wire e1, e2, e3, e4;

    // sum
    xor(e1, a, b);
    xor(s, e1, cin);

    // carry
    or(e2, a, b);
    and(e3, e2, cin);
    and(e4, a, b);
    or(c, e3, e4);

    assign sum = s;
    assign carry = c;
endmodule