module FA_24bit
(
    input [23:0] a,b,
    input c_in,
    output [23:0] result,
    output wire c_out
);
wire c_out1;
FA_8bit a0(
    .a(a[7:0]),
    .b(b[7:0]),
    .c_in(c_in),
    .result(result[7:0]),
    .c_out(c_out1)
);
FA_16bit a1(
    .a(a[23:8]),
    .b(b[23:8]),  
    .c_in(c_out1),
    .result(result[23:8]),
    .c_out(c_out)
);
endmodule