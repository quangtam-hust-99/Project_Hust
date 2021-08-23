module FA_8bit
(
    input [7:0] a,b,
    input wire c_in,
    output [7:0] result,
    output wire c_out
);/*
wire c_out1,c_out2,c_out3,c_out4,c_out5,c_out6,c_out7;
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
    .c_out(c_out4)
);
FA_1bit a5(
    .a(a[4]),
    .b(b[4]),
    .c_in(c_out4),
    .result(result[4]),
    .c_out(c_out5)
);
FA_1bit a6(
    .a(a[5]),
    .b(b[5]),
    .c_in(c_out5),
    .result(result[5]),
    .c_out(c_out6)
);
FA_1bit a7(
    .a(a[6]),
    .b(b[6]),
    .c_in(c_out6),
    .result(result[6]),
    .c_out(c_out7)
);
FA_1bit a8(
    .a(a[7]),
    .b(b[7]),
    .c_in(c_out7),
    .result(result[7]),
    .c_out(c_out)
);*/
FA_4bit a1(
    .a(a[3:0]),
    .b(b[3:0]),
    .c_in(c_in),
    .result(result[3:0]),
    .c_out(c_out1)
);
FA_4bit a2(
    .a(a[7:4]),
    .b(b[7:4]),
    .c_in(c_out1),
    .result(result[7:4]),
    .c_out(c_out)
);
endmodule