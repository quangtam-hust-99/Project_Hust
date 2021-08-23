module convert_Z_R
(
    input [15:0] in_Z,
    output [31:0] result
);
wire sign;
wire [7:0] ex;
wire [15:0] temp_z;
reg [22:0] fra;
reg [15:0] zahl;
reg [7:0] shift_ex;
assign sign=in_Z[15];
inviter_16bit zahl_convert
(
    .a(in_Z),
    .b(temp_z)
);
always @ *
    begin
        if(in_Z[15]==1)
            zahl=temp_z;
        else 
            zahl=in_Z;
    end

always @*
casex (zahl)
        16'b0000000000000001:
            begin
                fra=0;
                shift_ex=0;
            end
        16'b000000000000001x:
            begin
                fra={zahl[0],22'b0};
                shift_ex=1;
            end
        16'b00000000000001xx:
            begin
                fra={zahl[1:0],21'b0};
                shift_ex=2;
            end
        16'b0000000000001xxx:
            begin
                fra={zahl[2:0],20'b0};
                shift_ex=3;
            end
        16'b000000000001xxxx:
            begin
                fra={zahl[3:0],19'b0};
                shift_ex=4;
            end
        16'b00000000001xxxxx:
            begin
                fra={zahl[4:0],18'b0};
                shift_ex=5;
            end
        16'b0000000001xxxxxx:
            begin
                fra={zahl[5:0],17'b0};
                shift_ex=6;
            end
        16'b000000001xxxxxxx:
            begin
                fra={zahl[6:0],16'b0} ;
                shift_ex=7;
            end
        16'b00000001xxxxxxxx:
            begin
                fra={zahl[7:0],15'b0};
                shift_ex=8;
            end
        16'b0000001xxxxxxxxx:
            begin
                fra={zahl[8:0],14'b0};
                shift_ex=9;
            end
        16'b000001xxxxxxxxxx:
            begin
                fra={zahl[9:0],13'b0};
                shift_ex=10;
            end
        16'b00001xxxxxxxxxxx:
            begin
                fra={zahl[10:0],12'b0};
                shift_ex=11;
            end
        16'b0001xxxxxxxxxxxx:
            begin
                fra={zahl[11:0],11'b0};
                shift_ex=12;
            end
        16'b001xxxxxxxxxxxxx:
            begin
                fra={zahl[12:0],10'b0};
                shift_ex=13;
            end
        16'b01xxxxxxxxxxxxxx:
            begin
                fra={zahl[13:0],9'b0};
                shift_ex=14;
            end
        16'b1xxxxxxxxxxxxxxx:
            begin
                fra={zahl[14:0],8'b0};
                shift_ex=15;
            end
			default:
			begin
			fra=0;
			shift_ex=-127;
			end
endcase
FA_8bit add_ex
(
    .a(shift_ex),
    .b(8'd127),
    .c_in(1'b0),
    .result(ex)
);
assign result={sign,ex,fra};
endmodule