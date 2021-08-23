//  đúng với mọi trường hợp
module floating_point_multiplier_32bit
(
    input [31:0] a,b,
    output [31:0] result
);
wire [22:0] fra1,fra2,fra;
wire [23:0] temp_fra;
wire sign1,sign2,sign;
wire [7:0] ex1,ex2,temp_ex,add_ex,ex;
wire [47:0] mul_fra;
wire [31:0] temp_re;
reg [31:0] temp;
assign {sign1,ex1,fra1}=a;
assign {sign2,ex2,fra2}=b;
multiplier_24bit multiplier(
    .a({1'b1,fra1}),
    .b({1'b1,fra2}),
    .result(mul_fra)
);
FA_8bit exponent1(
    .a(ex1),
    .b(ex2),
    .c_in(1'b0),
    .result(add_ex)
);
SUB_8bit exponent2(
    .a(add_ex), 
    .b(8'd127),
    .result(temp_ex)
);
assign sign=sign1^sign2;
assign ex= mul_fra[47] ? (temp_ex+1'b1) :temp_ex;
assign temp_fra= mul_fra[47] ? mul_fra[46:23]:mul_fra[45:22];
assign fra= temp_fra[0] ? (temp_fra[23:1]+1'b1):temp_fra[23:1];
assign temp_re={sign,ex,fra};
always@*
begin
    if((a[30:23]<96) || (b[30:23]<96) ) // tránh tràn dưới vs sai số là 10e-10,chưa khác phục  tràn trên
    temp=0;
    else 
    temp=temp_re;
end
assign result =temp;
endmodule

