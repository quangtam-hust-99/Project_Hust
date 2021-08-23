module convert_R_Z
(
    input [31:0] in_R,
    output [15:0] result
);
wire [7:0] shift_ex;
wire [23:0] fra;
wire [15:0] b,temp_b;
reg [15:0] temp_fra;
reg [15:0] temp_re;
SUB_8bit exponent(
    .a(in_R[31:23]),
    .b(8'd127),
    .result(shift_ex)
);

assign fra={1'b1,in_R[22:0]};
always @*

    casex (shift_ex)
    8'b1xxxxxxx:
    begin
        temp_fra=0;
    end
    8'd0:
    begin
        temp_fra={15'b0,fra[23]};
    end
    8'd1:
    begin
        temp_fra={14'b0,fra[23:22]};
    end
    8'd2:
    begin
        temp_fra={13'b0,fra[23:21]};
    end
    8'd3:
    begin
        temp_fra={12'b0,fra[23:20]};
    end
    8'd4:
    begin
        temp_fra={11'b0,fra[23:19]};
    end
    8'd5:
    begin
        temp_fra={10'b0,fra[23:18]};
    end
    8'd6:
    begin
        temp_fra={9'b0,fra[23:17]};
    end
    8'd7:
    begin
        temp_fra={8'b0,fra[23:16]};
    end
    8'd8:
    begin
        temp_fra={7'b0,fra[23:15]};
    end
    8'd9:
    begin
        temp_fra={6'b0,fra[23:14]};
    end
    8'd10:
    begin
        temp_fra={5'b0,fra[23:13]};
    end  
    8'd11:
    begin
        temp_fra={4'b0,fra[23:12]};
    end
    8'd12:
    begin
        temp_fra={3'b0,fra[23:11]};
    end
    8'd13:
    begin
        temp_fra={2'b0,fra[23:10]};
    end
    8'd14:
    begin
        temp_fra={1'b0,fra[23:9]};
    end
    default:
         temp_fra=fra[23:8];
    endcase
assign b=temp_fra;
inviter_16bit invert_b(
    .a(b),
    .b(temp_b)
);
always @*
begin
    if(in_R[31]==0)//38735
        temp_re=b;
    else 
        temp_re=temp_b ;
end
assign result=temp_re;
endmodule
