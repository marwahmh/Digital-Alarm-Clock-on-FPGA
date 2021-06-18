`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module sync( input clk , in1, reset,  output reg in2   );
reg q0;
always @ ( posedge clk) begin
if (!reset) begin
    q0 <= in1;
    in2 <= q0;
    end
    
    end
endmodule
