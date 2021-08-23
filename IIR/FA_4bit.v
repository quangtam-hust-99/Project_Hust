module FA_4bit
(
    input [3:0] a,b,
    input wire c_in,
    output wire [3:0] result,
    output wire c_out
);
wire c_out1,c_out2,c_out3;
FA_1bit a1(
    .a(a[0]),
    .b(b[0]),
    .c_in(c_in),
    .result(result[0]),
    .c_out(c_out1)
);
FA_1bit a2(
    .a(a[1]),
    .b(b[1]),
    .c_in(c_out1),
    .result(result[1]),
    .c_out(c_out2)
);
FA_1bit a3(
    .a(a[2]),
    .b(b[2]),
    .c_in(c_out2),
    .result(result[2]),
    .c_out(c_out3)
);
FA_1bit a4(
    .a(a[3]),
    .b(b[3]),
    .c_in(c_out3),
    .result(result[3]),
    .c_out(c_out)
);
endmodule