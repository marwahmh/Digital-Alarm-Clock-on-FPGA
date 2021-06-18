`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


module count_mod10(input clk,rst,en, output [3:0] count);
wire c_out;
ClockDivider #(50000000)C1( .clk(clk),.rst(rst), .clk_out(c_out));
BinaryCounter  #(4,10) B1(.e(en),.reset(rst),.clk(c_out),.count(count));
endmodule
