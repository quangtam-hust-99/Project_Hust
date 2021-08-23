/*
* @Author:				thien
* @Email:				thienndbkak61@gmail.com
* @Date:				2019-09-21 16:17:44
* @Last Modified by:	thien
* @Last Modified time:	2019-09-29 21:14:57
*/

module FSK_mod(
    input [7:0] data,
	input clk,
	input rst_n,
	output cs_dac,
	output sclk_dac,
	output mosi_dac 
	);
wire [11:0] data_sin;
wire [11:0] select;
Bit_rate_1Khz Bit_rate_1Khz (
	.data(data),
	.clk(clk),
	.rst_n(rst_n),
	.select(select)
	);

sin_data sin_data (
	.clk(clk),
	.rst_n(rst_n),
	.select(select),
	.data_sin(data_sin)
	);

dac_out dac_out (
	.clk(clk),
	.rst_n(rst_n),
	.data_in(data_sin),
	.mosi_out(mosi_dac),
	.cs_out(cs_dac),
	.sclk_out(sclk_dac)
	);
endmodule