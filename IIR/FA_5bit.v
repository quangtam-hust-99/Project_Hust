module FA_5bit
(
    input [4:0] a,b,
    input c_in,
    output [4:0] result,
    output wire c_out
);
wire c_out1;
FA_4bit FA_a0(
    .a(a[3:0]),
    .b(b[3:0]),
    .c_in(c_in),
    .result(result[3:0]),
    .c_out(c_out1)
);
FA_1bit FA_a1(
    .a(a[4]),
    .b(b[4]),
    .c_in(c_out1),
    .result(result[4]),
    .c_out(c_out)
);
endmodule