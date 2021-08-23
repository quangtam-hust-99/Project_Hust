module floating_point_adder_32bit
(
    input [31:0] a,b,
    output [31:0] result
);
reg sign;
reg [22:0] big_fra,small_fra;
reg [7:0] big_ex,small_ex;
reg [23:0] shifted_small_fra;
wire [7:0] diff_ex;
wire [23:0] big_float,small_float,samesum;
wire sum_carry;

always @*
    begin
        if(a[31:23]>b[31:23])
            begin
                {big_ex,big_fra}=a[30:0];
                {small_ex,small_fra}=b[30:0];
                sign=a[31];
            end 
        else if (a[31:23]==b[31:23])
            begin
                if(a[22:0]>b[22:0])
                    begin
                        {big_ex,big_fra}=a[30:0];
                        {small_ex,small_fra}=b[30:0];
                        sign=a[31];
                    end
                else
                    begin
                        {big_ex,big_fra}=b[30:0];
                        {small_ex,small_fra}=a[30:0];
                        sign=b[31];
                    end
            end
        else
            begin
                {big_ex,big_fra}=b[30:0];
                {small_ex,small_fra}=a[30:0];
                sign=b[31];
            end
    end
SUB_8bit diff_exponenet(
    .a(big_ex),
    .b(small_ex),
    .result(diff_ex)
);

assign big_float={1'b1,big_fra};
assign small_float={1'b1,small_fra};
always @*
begin
    case(diff_ex)
        8'd0:shifted_small_fra=small_float;
        8'd1:shifted_small_fra=(small_float >> 1);
        8'd2:shifted_small_fra=(small_float >> 2);
        8'd3:shifted_small_fra=(small_float >> 3);
        8'd4:shifted_small_fra=(small_float >> 4);
        8'd5:shifted_small_fra=(small_float >> 5);
        8'd6:shifted_small_fra=(small_float >> 6);
        8'd7:shifted_small_fra=(small_float >> 7);
        8'd8:shifted_small_fra=(small_float >> 8);
        8'd9:shifted_small_fra=(small_float >> 9);
        8'd10:shifted_small_fra=(small_float >> 10);
        8'd11:shifted_small_fra=(small_float >> 11);
        8'd12:shifted_small_fra=(small_float >> 12);
        8'd13:shifted_small_fra=(small_float >> 13);
        8'd14:shifted_small_fra=(small_float >> 14);
        8'd15:shifted_small_fra=(small_float >> 15);
        8'd16:shifted_small_fra=(small_float >> 16);
        8'd17:shifted_small_fra=(small_float >> 17);
        8'd18:shifted_small_fra=(small_float >> 18);
        8'd19:shifted_small_fra=(small_float >> 19);
        8'd20:shifted_small_fra=(small_float >> 20);
        8'd21:shifted_small_fra=(small_float >> 21);
        8'd22:shifted_small_fra=(small_float >> 22);
        8'd23:shifted_small_fra=(small_float >> 23);
        default:shifted_small_fra=0;
    endcase
end 
FA_24bit sum_fra(
    .a(big_float),
    .b(shifted_small_fra),
    .c_in(1'b0),
    .result(samesum),
    .c_out(sum_carry)
);
assign result[22:0]=sum_carry ? samesum[23:1]:samesum[22:0];
assign result[30:23]=sum_carry ? (big_ex+1'b1):big_ex;
assign result[31]=sign;
endmodule