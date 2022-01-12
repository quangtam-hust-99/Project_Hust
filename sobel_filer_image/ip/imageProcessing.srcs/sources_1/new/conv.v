
module conv(
input        i_clk,
input [71:0] i_pixel_data,
input        i_pixel_data_valid,
output reg [7:0] o_convolved_data,
output reg   o_convolved_data_valid
    );
    
integer i; 
reg [7:0] kernel1 [8:0]; // 9 phan tu kernel1 8bit
reg [7:0] kernel2 [8:0];
reg [10:0] multData1[8:0];
reg [10:0] multData2[8:0];
reg [10:0] sumDataInt1;
reg [10:0] sumDataInt2;
reg [10:0] sumData1;
reg [10:0] sumData2;
reg multDataValid;
reg sumDataValid;
reg convolved_data_valid;
reg [20:0] convolved_data_int1;
reg [20:0] convolved_data_int2;
wire [21:0] convolved_data_int;
reg convolved_data_int_valid;

initial
begin
    kernel1[0] =  1;
    kernel1[1] =  0;
    kernel1[2] = -1;
    kernel1[3] =  2;
    kernel1[4] =  0;
    kernel1[5] = -2;
    kernel1[6] =  1;
    kernel1[7] =  0;
    kernel1[8] = -1;
    
    kernel2[0] =  1;
    kernel2[1] =  2;
    kernel2[2] =  1;
    kernel2[3] =  0;
    kernel2[4] =  0;
    kernel2[5] =  0;
    kernel2[6] = -1;
    kernel2[7] = -2;
    kernel2[8] = -1;
end    
    
always @(posedge i_clk)
begin

    for(i=0;i<9;i=i+1)
    begin
        multData1[i] <= $signed(kernel1[i])*$signed({1'b0,i_pixel_data[i*8+:8]});// (i*8)+7 : i*8
        multData2[i] <= $signed(kernel2[i])*$signed({1'b0,i_pixel_data[i*8+:8]});
    end
    
    /*
    multData1[0]<=$signed(kernel1[0])*$signed({1'b0,i_pixel_data[7:0]});
    multData1[1]<=$signed(kernel1[1])*$signed({1'b0,i_pixel_data[15:8]});
    multData1[2]<=$signed(kernel1[2])*$signed({1'b0,i_pixel_data[23:16]});
    multData1[3]<=$signed(kernel1[3])*$signed({1'b0,i_pixel_data[31:24]});
    multData1[4]<=$signed(kernel1[4])*$signed({1'b0,i_pixel_data[39:32]});
    multData1[5]<=$signed(kernel1[5])*$signed({1'b0,i_pixel_data[47:40]});
    multData1[6]<=$signed(kernel1[6])*$signed({1'b0,i_pixel_data[55:48]});
    multData1[7]<=$signed(kernel1[7])*$signed({1'b0,i_pixel_data[63:56]});
    multData1[8]<=$signed(kernel1[8])*$signed({1'b0,i_pixel_data[71:64]});
    
    multData2[0]<=$signed(kernel2[0])*$signed({1'b0,i_pixel_data[7:0]});
    multData2[1]<=$signed(kernel2[1])*$signed({1'b0,i_pixel_data[15:8]});
    multData2[2]<=$signed(kernel2[2])*$signed({1'b0,i_pixel_data[23:16]});
    multData2[3]<=$signed(kernel2[3])*$signed({1'b0,i_pixel_data[31:24]});
    multData2[4]<=$signed(kernel2[4])*$signed({1'b0,i_pixel_data[39:32]});
    multData2[5]<=$signed(kernel2[5])*$signed({1'b0,i_pixel_data[47:40]});
    multData2[6]<=$signed(kernel2[6])*$signed({1'b0,i_pixel_data[55:48]});
    multData2[7]<=$signed(kernel2[7])*$signed({1'b0,i_pixel_data[63:56]});
    multData2[8]<=$signed(kernel2[8])*$signed({1'b0,i_pixel_data[71:64]});
    */
    multDataValid <= i_pixel_data_valid;
end


always @(*)
begin
    sumDataInt1 = 0;
    sumDataInt2 = 0;
        sumDataInt1 = $signed(sumDataInt1) + $signed(multData1[0]);
        sumDataInt1 = $signed(sumDataInt1) + $signed(multData1[1]);
        sumDataInt1 = $signed(sumDataInt1) + $signed(multData1[2]);
        sumDataInt1 = $signed(sumDataInt1) + $signed(multData1[3]);
        sumDataInt1 = $signed(sumDataInt1) + $signed(multData1[4]);
        sumDataInt1 = $signed(sumDataInt1) + $signed(multData1[5]);
        sumDataInt1 = $signed(sumDataInt1) + $signed(multData1[6]);
        sumDataInt1 = $signed(sumDataInt1) + $signed(multData1[7]);
        sumDataInt1 = $signed(sumDataInt1) + $signed(multData1[8]);
        
        sumDataInt2 = $signed(sumDataInt2) + $signed(multData2[0]);
        sumDataInt2 = $signed(sumDataInt2) + $signed(multData2[1]);
        sumDataInt2 = $signed(sumDataInt2) + $signed(multData2[2]);
        sumDataInt2 = $signed(sumDataInt2) + $signed(multData2[3]);
        sumDataInt2 = $signed(sumDataInt2) + $signed(multData2[4]);
        sumDataInt2 = $signed(sumDataInt2) + $signed(multData2[5]);
        sumDataInt2 = $signed(sumDataInt2) + $signed(multData2[6]);
        sumDataInt2 = $signed(sumDataInt2) + $signed(multData2[7]);
        sumDataInt2 = $signed(sumDataInt2) + $signed(multData2[8]);
end

always @(posedge i_clk)
begin
    sumData1 <= sumDataInt1;
    sumData2 <= sumDataInt2;
    sumDataValid <= multDataValid;
end

always @(posedge i_clk)
begin
    convolved_data_int1 <= $signed(sumData1)*$signed(sumData1);
    convolved_data_int2 <= $signed(sumData2)*$signed(sumData2);
    convolved_data_int_valid <= sumDataValid;
end

assign convolved_data_int = convolved_data_int1+convolved_data_int2;

    
always @(posedge i_clk)
begin
    if(convolved_data_int > 3000)
        o_convolved_data <= 8'h00;
    else
        o_convolved_data <= 8'hff;
    o_convolved_data_valid <= convolved_data_int_valid;
end
    
endmodule
