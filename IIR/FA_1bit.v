module FA_1bit
(
    input wire a,b,c_in,
    output wire result,c_out
);
assign result=(~a&~b&c_in)|(~a&b&~c_in)|(a&b&c_in)|(a&~b&~c_in);
assign c_out=(a&b)|(a&c_in)|(b&c_in);
endmodule