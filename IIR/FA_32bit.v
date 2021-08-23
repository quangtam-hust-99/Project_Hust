module FA_32bit
(
    input [31:0] a,b,
    input wire c_in,
    output [31:0] result,
    output wire c_out
);
wire c_out0;
FA_16bit a0(
    .a(a[15:0]),
    .b(b[15:0]),
    .c_in(c_in),
    .result(result[15:0]),
    .c_out(c_out0)
);
FA_16bit a1(
    .a(a[31:16]),
    .b(b[31:16]),
    .c_in(c_out0),
    .result(result[31:16]),
    .c_out(c_out)
);
endmodule