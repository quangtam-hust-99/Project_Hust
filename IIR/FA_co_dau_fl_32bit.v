module FA_co_dau_fl_32bit
(
    input [31:0] a,b,
    output reg [31:0] result
);
reg [31:0] a_in,b_in;
wire [31:0] result_add,result_sub;
floating_point_adder_32bit adder_32bit(
    .a(a_in),
    .b(b_in),
    .result(result_add)
);
floating_point_subtractor_32bit subtractor_32bit(
    .a(a_in),
    .b(b_in),
    .result(result_sub)
);
always @*
    begin
        if(a[31]^b[31]==0)
            begin
                a_in=a;
                b_in=b;
                result=result_add;
            end
        else if( (a[31]==0) && (b[31]==1))
            begin
                a_in=a;
                b_in={1'b0,b[30:0]};
                result=result_sub;
            end
        else if ( (a[31]==1) && (b[31]==0))
            begin
                a_in=b;
                b_in={1'b0,a[30:0]};
                result=result_sub;
            end
    end
endmodule