module section
(
    input clk,reset,
    input signed[31:0] filter_in,
    input signed[31:0] b0,b1,b2,a1,a2,
    output  wire signed [31:0] filter_out

);
reg [31:0] reg_x1,reg_x2;// thanh ghi dịch đầu vào
reg [31:0] reg_y1,reg_y2;//thanh ghi dịch đầu ra
wire signed[31:0] reg_next_x1,reg_next_x2,data;
wire signed[31:0] reg_next_y1,reg_next_y2;
wire signed[31:0] temp_x1,temp_x2,temp_x3,temp_y1,temp_y2;
wire signed[31:0] temp_re1,temp_re2,temp_re3,temp_re4,out_sec;
/*always @ (posedge clk or negedge reset)
begin 
    if(reset)
    data<=0;
    else
    data<=filter_in;
end*/


always @(posedge clk or posedge reset)
    begin 
        if(reset==1)
        begin
            reg_x1<=0;
            reg_x2<=0;
            reg_y1<=0;
            reg_y2<=0;
        end
        else
        begin
            reg_x1<=reg_next_x1;
            reg_x2<=reg_next_x2;
            reg_y1<=reg_next_y1;
            reg_y2<=reg_next_y2;
        end
    end

  assign reg_next_x1=filter_in;
  assign reg_next_x2= reg_x1;
  assign reg_next_y1=filter_out;
  assign reg_next_y2=reg_y1;
//floating_point_multiplier_32bit mul_gain1 (.a(filter_in),.b(g),.result(data));
floating_point_multiplier_32bit mul_reg_x0(.a(filter_in),.b(b0),.result(temp_x1));
floating_point_multiplier_32bit mul_reg_x1(.a(reg_x1),.b(b1),.result(temp_x2));
floating_point_multiplier_32bit mul_reg_x2(.a(reg_x2),.b(b2),.result(temp_x3));
floating_point_multiplier_32bit mul_reg_y1(.a(reg_y1),.b(a1),.result(temp_y1));
floating_point_multiplier_32bit mul_reg_y2(.a(reg_y2),.b(a2),.result(temp_y2));
FA_co_dau_fl_32bit FA_reg_x0(.a(temp_x1),.b(temp_x2),.result(temp_re1));
FA_co_dau_fl_32bit FA_reg_x1(.a(temp_re1),.b(temp_x3),.result(temp_re2));
FA_co_dau_fl_32bit FA_reg_y1(.a(temp_re2),.b(temp_y1),.result(temp_re3));
FA_co_dau_fl_32bit FA_reg_y2(.a(temp_re3),.b(temp_y2),.result(temp_re4));

assign filter_out=temp_re4  ;
endmodule