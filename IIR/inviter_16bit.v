module inviter_16bit
(
    input [15:0] a,
    output [15:0] b
);
wire [15:0]temp;
assign temp=~a;
FA_16bit a1(
    .a(1),
    .b(temp),
    .c_in(1'b0),
    .result(b)
);
endmodule