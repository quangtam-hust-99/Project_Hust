module FA_48bit
(
    input [47:0] a,b,
    input c_in,
    output [47:0] result,
    output wire c_out
);
wire c_out0;
FA_32bit a0(
    .a(a[47:16]),
    .b(b[47:16]),
    .c_in(c_in),
    .result(result[47:16]),
    .c_out(c_out0)
);
FA_16bit a1(
    .a(a[15:0]),
    .b(b[15:0]),
    .c_in(c_out0),
    .result(result[15:0]),
    .c_out(c_out)
);
endmodule