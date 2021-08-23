module SUB_8bit
(
    input [7:0] a,b,
    output [7:0] result
);
wire [7:0] temp_b,b_in;
assign temp_b=~b;
FA_8bit a0(
    .a(temp_b),
    .b(8'd1),
    .c_in(1'b0),
    .result(b_in)
);
FA_8bit a1(
    .a(a),
    .b(b_in),
    .c_in(1'b0),
    .result(result)
);
endmodule