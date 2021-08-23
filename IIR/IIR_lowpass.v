module IIR_lowpass
(
    input clk,reset,
    input [15:0] filter_in,
    output [15:0] filter_out
);
	// các hệ số gain nhân trực tiếp vào tử số b
	// fs=125khz
	// fc=10khz
  	localparam signed [31:0]	b01=32'b00111101011010111001001000010101	;
	localparam signed [31:0]	b11=32'b00111101111010111001001000010101	;
	localparam signed [31:0]	b21=32'b00111101011010111001001000010101	;
	localparam signed [31:0]	a11=32'b00111111110100001001110011100011	;
	localparam signed [31:0]	a21=32'b10111111010111000001111001001100	;
   // localparam signed [31:0]  g1=32'b00111101011010111001001000010101;
	localparam signed [31:0]	b02=32'b00111101010011111101110010110000	;
	localparam signed [31:0]	b12=32'b00111101110011111101110010110000	;
	localparam signed [31:0]	b22=32'b00111101010011111101110010110000	;
	localparam signed [31:0]	a12=32'b00111111101110000001001100111100	;
	localparam signed [31:0]	a22=32'b10111111001001000001110110100101	;
   //localparam signed [31:0]  g2=32'b00111101010011111101110010110000;
	localparam signed [31:0]	b03=32'b00111101001111001111010010110011	;
	localparam signed [31:0]	b13=32'b00111101101111001111010010110011;
	localparam signed [31:0]	b23=32'b00111101001111001111010010110011	;
	localparam signed [31:0]	a13=32'b00111111101001110101010100011101	;
	localparam signed [31:0]	a23=32'b10111110111110111100111011010000	;
  // localparam signed [31:0]  g3=32'b00111101001111001111010010110011;
	localparam signed [31:0]	b04=32'b00111101001100010011111000111011	;
	localparam signed [31:0]	b14=32'b00111101101100010011111000111011	;
	localparam signed [31:0]	b24=32'b00111101001100010011111000111011	;
	localparam signed [31:0]	a14=32'b00111111100111001111010111000111	;
  	localparam signed [31:0]	a24=32'b10111110110011000111011000111100	;
 // localparam signed [31:0]  g4=32'b00111101001100010011111000111011;
	localparam signed [31:0]	b05=32'b00111101001010111010011000111001	;
	localparam signed [31:0]	b15=32'b00111101101010111010011000111001	;
	localparam signed [31:0]	b25=32'b00111101001010111010011000111001	;
	localparam signed [31:0]	a15=32'b00111111100110000000000110100101	;
	localparam signed [31:0]	a25=32'b10111110101101011101100110110010	;
   //localparam signed [31:0]  g5=32'b00111101001010111010011000111001;


wire clk_125k;
wire [31:0] data_in;
wire [31:0] temp_sec1,temp_sec2,temp_sec3,temp_sec4,temp_sec5;
chia_tan #(.M(399),.N(10))div_clk_125k
(
    .clk(clk),
    .reset(reset),
    .div_clk(clk_125k)
);

convert_Z_R convert_filter_in(.in_Z(filter_in),.result(data_in));
section section1( .clk(clk_125k), .reset(reset), .filter_in(data_in), .b0(b01), .b1(b11), .b2(b21), .a1(a11), .a2(a21), .filter_out(temp_sec1) );
section section2( .clk(clk_125k), .reset(reset), .filter_in(temp_sec1), .b0(b02), .b1(b12), .b2(b22), .a1(a12), .a2(a22), .filter_out(temp_sec2)  );
section section3( .clk(clk_125k), .reset(reset), .filter_in(temp_sec2), .b0(b03), .b1(b13), .b2(b23), .a1(a13), .a2(a23), .filter_out(temp_sec3) );
section section4( .clk(clk_125k), .reset(reset), .filter_in(temp_sec3), .b0(b04), .b1(b14), .b2(b24), .a1(a14), .a2(a24), .filter_out(temp_sec4) );
section section5( .clk(clk_125k), .reset(reset), .filter_in(temp_sec4), .b0(b05), .b1(b15), .b2(b25), .a1(a15), .a2(a25), .filter_out(temp_sec5) );
convert_R_Z convert_result(.in_R(temp_sec5),.result(filter_out));

endmodule