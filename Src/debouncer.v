`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module debouncer( input in1, input clk, reset, output in2 );
reg Q0,Q1,Q;
always @ (posedge clk or posedge reset) 
begin
    if (!reset) begin
    Q0  <= in1;
    Q1 <= Q0;
    Q<= Q1;
    end
end
assign in2 = Q0 & Q1 & Q ;
endmodule
