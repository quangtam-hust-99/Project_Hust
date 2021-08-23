module FA_16bit(
    input wire [15:0] a,b,
    input wire c_in,
    output [15:0] result,
    output wire c_out
);
wire c_out1;
FA_8bit a1(
    .a(a[7:0]),
    .b(b[7:0]),
    .c_in(c_in),
    .result(result[7:0]),
    .c_out(c_out1)
);
FA_8bit a2(
    .a(a[15:8]),
    .b(b[15:8]),
    .c_in(c_out1),
    .result(result[15:8]),
    .c_out(c_out)
);
endmodule