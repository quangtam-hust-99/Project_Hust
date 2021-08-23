module floating_point_subtractor_32bit
(
    input [31:0] a,b,
    output [31:0] result
);
reg signR;
wire [7:0] ex1,ex2, diff_ex;
wire [23:0] fra1,fra2,small_fre_float,sum;
reg [22:0] fraR;
reg [23:0] big_fra,small_fra;
reg [23:0] shifted_small_fra;
reg [7:0] big_ex,small_ex ,exR  ;
assign ex1=a[30:23];
assign ex2=b[30:23];
assign fra1={1'b1,a[22:0]};
assign fra2={1'b1,b[22:0]};

// compare number
always @(*)
    begin
        if(a[30:23]>b[30:23])
            begin
                {big_ex,big_fra}={ex1,fra1};
                {small_ex,small_fra}={ex2,fra2};
                signR=1'b0;
            end
        else if (a[30:23]==b[30:23])
            begin
                if(a[22:0]>b[22:0])
                    begin
                        {big_ex,big_fra}={ex1,fra1};
                        {small_ex,small_fra}={ex2,fra2};
                        signR=1'b0;
                    end
                else
                    begin
                        {big_ex,big_fra}={ex2,fra2};
                        {small_ex,small_fra}={ex1,fra1};
                        signR=1'b1;
                    end
            end
        else
            begin
                {big_ex,big_fra}={ex2,fra2};
                {small_ex,small_fra}={ex1,fra1};
                signR=1'b1;
            end      
    end

//differen exponent
SUB_8bit compare_ex(
    .a(big_ex),
    .b(small_ex),
    .result(diff_ex)
);
always @*
begin
    case(diff_ex)
        8'd0:shifted_small_fra=small_fra;
        8'd1:shifted_small_fra=(small_fra >> 1);
        8'd2:shifted_small_fra=(small_fra >> 2);
        8'd3:shifted_small_fra=(small_fra >> 3);
        8'd4:shifted_small_fra=(small_fra >> 4);
        8'd5:shifted_small_fra=(small_fra >> 5);
        8'd6:shifted_small_fra=(small_fra >> 6);
        8'd7:shifted_small_fra=(small_fra >> 7);
        8'd8:shifted_small_fra=(small_fra >> 8);
        8'd9:shifted_small_fra=(small_fra >> 9);
        8'd10:shifted_small_fra=(small_fra >> 10);
        8'd11:shifted_small_fra=(small_fra >> 11);
        8'd12:shifted_small_fra=(small_fra >> 12);
        8'd13:shifted_small_fra=(small_fra >> 13);
        8'd14:shifted_small_fra=(small_fra >> 14);
        8'd15:shifted_small_fra=(small_fra >> 15);
        8'd16:shifted_small_fra=(small_fra >> 16);
        8'd17:shifted_small_fra=(small_fra >> 17);
        8'd18:shifted_small_fra=(small_fra >> 18);
        8'd19:shifted_small_fra=(small_fra >> 19);
        8'd20:shifted_small_fra=(small_fra >> 20);
        8'd21:shifted_small_fra=(small_fra >> 21);
        8'd22:shifted_small_fra=(small_fra >> 22);
        8'd23:shifted_small_fra=(small_fra >> 23);
        default:shifted_small_fra=0;
    endcase
end 

//two's complement bit b
/*
always @*
    begin
        if(a[30:23]>b[30:23])
            begin
            temp_fra2=shifted_small_fra;
            temp_fra1=fra1;
            end
        else if (a[30:23]==b[30:23])
            begin
                if(a[22:0]>b[22:0])
                    begin
                    temp_fra2=shifted_small_fra;
                    temp_fra1=fra1;
                    end
                else
                    begin
                    temp_fra2=fra2;
                    temp_fra1=shifted_small_fra;
                    end
            end
        else
            begin
            temp_fra2=fra2;
            temp_fra1=shifted_small_fra;
            end
    end*/
two_s_complement_24bit complement_bit_b(
    .a(shifted_small_fra),
    .b(small_fre_float)
);

//additon
FA_24bit add(
    .a(big_fra),
    .b(small_fre_float),
	.c_in(1'b0),
    .result(sum)
);

// normalize result
always @*
begin
    casex(sum)
        24'b1xxxxxxxxxxxxxxxxxxxxxxx:
            begin
                exR=big_ex;
                fraR=sum[22:0];
            end
        24'b01xxxxxxxxxxxxxxxxxxxxxx:
            begin
                exR=big_ex-8'd1;
                fraR={sum[21:0],1'b0};
            end
        24'b001xxxxxxxxxxxxxxxxxxxxx:
            begin
                exR=big_ex-8'd2;
                fraR={sum[20:0],2'b0};
            end
        24'b0001xxxxxxxxxxxxxxxxxxxx:
            begin
                exR=big_ex-8'd3;
                fraR={sum[19:0],3'b0};
            end
        24'b00001xxxxxxxxxxxxxxxxxxx:
            begin
                exR=big_ex-8'd4;
                fraR={sum[18:0],4'b0};
            end
        24'b000001xxxxxxxxxxxxxxxxxx:
            begin
                exR=big_ex-8'd5;
                fraR={sum[17:0],5'b0};
            end
        24'b0000001xxxxxxxxxxxxxxxxx:
            begin
                exR=big_ex-8'd6;
                fraR={sum[16:0],6'b0};
            end
        24'b00000001xxxxxxxxxxxxxxxx:
            begin
                exR=big_ex-8'd7;
                fraR={sum[15:0],7'b0};
            end
        24'b000000001xxxxxxxxxxxxxxx:
            begin
                exR=big_ex-8'd8;
                fraR={sum[14:0],8'b0};
            end
        24'b0000000001xxxxxxxxxxxxxx:
            begin
                exR=big_ex-8'd9;
                fraR={sum[13:0],9'b0};
            end
        24'b00000000001xxxxxxxxxxxxx:
            begin
                exR=big_ex-8'd10;
                fraR={sum[12:0],10'b0};
            end
        24'b000000000001xxxxxxxxxxx:
            begin
                exR=big_ex-8'd11;
                fraR={sum[11:0],11'b0};
            end
        24'b0000000000001xxxxxxxxxx:
            begin
                exR=big_ex-8'd12;
                fraR={sum[10:0],12'b0};
            end
        24'b00000000000001xxxxxxxxx:
            begin
                exR=big_ex-8'd13;
                fraR={sum[9:0],13'b0};
            end
        24'b000000000000001xxxxxxxx:
            begin
                exR=big_ex-8'd14;
                fraR={sum[8:0],14'b0};
            end
        24'b0000000000000001xxxxxxx:
            begin
                exR=big_ex-8'd15;
                fraR={sum[7:0],15'b0};
            end
        24'b00000000000000001xxxxxx:
            begin
                exR=big_ex-8'd16;
                fraR={sum[6:0],16'b0};
            end
        24'b000000000000000001xxxxx:
            begin
                exR=big_ex-8'd17;
                fraR={sum[5:0],17'b0};
            end
        24'b0000000000000000001xxxx:
            begin
                exR=big_ex-8'd18;
                fraR={sum[4:0],18'b0};
            end
        24'b00000000000000000001xxx:
            begin
                exR=big_ex-8'd19;
                fraR={sum[3:0],19'b0};
            end
        24'b000000000000000000001xx:
            begin
                exR=big_ex-8'd20;
                fraR={sum[2:0],20'b0};
            end
        24'b0000000000000000000001x:
            begin
                exR=big_ex-8'd21;
                fraR={sum[1:0],21'b0};
            end
        24'b00000000000000000000001:
            begin
                exR=big_ex-8'd22;
                fraR={sum[0],22'b0};
            end
        default:
            begin
                exR=big_ex-8'd23;
                fraR=23'b0;
            end
    endcase
       
end
assign result={signR,exR,fraR};
endmodule