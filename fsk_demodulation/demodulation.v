module demodulation //giải điều chế
(
    input clk,reset,
    output reg fsk_demod
);
wire [15:0] m1,m2;
wire [15:0] mm1,mm2;
mul_signal mul_signal_mod(
    .clk(clk),
    .reset(reset),
    .mul_signal_f1(m1),
    .mul_signal_f2(m2)
);
FIR_lowpass fir_f1(
    .clk(clk),
    .reset(reset),
    .signal_in(m1),
    .signal_out(mm1)
);
FIR_lowpass fir_f2(
    .clk(clk),
    .reset(reset),
    .signal_in(m2),
    .signal_out(mm2)
);
always @*
begin
  if(mm2>=16'd0) 
  fsk_demod<=0;
  else if(mm2<-16'd1)
  fsk_demod<=1;
end/*
always @*
begin
  if((temp_demod>900) && (temp_demod<1024))
  fsk_demod<=1;
  else
  fsk_demod<=0;
end*/
endmodule