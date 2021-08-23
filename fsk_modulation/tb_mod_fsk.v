`timescale 1ns/1ps
module tb_mod_fsk();
    reg clk, reset;
    reg [7:0] data;
    wire cs_dac, sclk_dac, mosi_dac;
mod_fsk uut(
    .clk(clk),
    .reset(reset),
    .data(data),
    .cs_dac(cs_dac),
    .sclk_dac(sclk_dac),
    .mosi_dac(mosi_dac)
    );
initial begin
    clk = 0;
    reset = 0;
    data = 8'b10000001;
    #100;
    reset = 1;
    #5;
end
always #5 clk = !clk;
endmodule
