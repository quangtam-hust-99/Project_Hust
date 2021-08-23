module two_s_complement_24bit
(
    input [23:0] a,
    output [23:0] b
);
wire [23:0] temp_a;
assign temp_a=~a;
FA_24bit complement_24bit(
    .a(temp_a),
    .b(24'b1),
    .c_in(1'b0),
    .result(b)
);
endmodule