module chia_tan
#(parameter N =5,M=10 )
(
    input  clk,reset,
    output reg div_clk
);
reg [N-1:0] count;
always @(posedge clk or posedge reset)
begin
    if(reset==1)
    begin
        div_clk<=1'b0;
      count<=0;
    end
      
    else if(count==M)
        begin
            div_clk<=~div_clk;
            count<=0;
        end
    else
        count<=count+1'b1;
end
endmodule