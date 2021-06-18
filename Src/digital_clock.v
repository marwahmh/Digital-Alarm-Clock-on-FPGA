`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 

module digital_clock( input clk,rst,en0,ld,input [3:0]adj_HT,adj_HU,adj_MT, adj_MU , output [3:0] minTens, secTens, output  [3:0] minUnits , secUnits ,HourUnits, output  [3:0] HourTens, output dot);
wire c_out,c_out2;
wire en1,en2,en3,en4,en5,en6;
wire hu1, hu2;
assign en1 = ( en0==1 && (secUnits==4'b1001)) ? 1:0;
assign en2 = ( en1==1 && (secTens==4'b0101)) ? 1:0;
assign en3 = ( en2==1 && (minUnits==4'b1001)) ? 1:0;
assign en4 = ( en3==1 && (minTens==4'b0101) ) ? 1:0;
assign en5 = ( en4==1  && (HourUnits==4'b1001) ) ? 1:0;

wire reset;

ClockDivider #(50000000)C1( .clk(clk),.rst(rst), .clk_out(c_out));

BinaryCounter  #(4,10) S_1(.en(en0|ld),.reset(rst | reset),.clk(c_out),.count(secUnits),.ld(ld),.adj_count(0));
BinaryCounter  #(4,6) S_10(.en(en1|ld),.reset(rst | reset),.clk(c_out),.count(secTens),.ld(ld),.adj_count(0));
BinaryCounter  #(4,10) M_1(.en(en2|ld),.reset(rst | reset),.clk(c_out),.count(minUnits),.ld(ld),.adj_count(adj_MU));
BinaryCounter  #(4,6) M_10(.en(en3|ld),.reset(rst | reset),.clk(c_out),.count(minTens),.ld(ld),.adj_count(adj_MT));
BinaryCounter  #(4,10) H_1(.en(en4|ld),.reset(rst | reset),.clk(c_out),.count(HourUnits),.ld(ld),.adj_count(adj_HU));
BinaryCounter  #(4,3) H_10(.en(en5|ld),.reset(rst | reset),.clk(c_out),.count(HourTens),.ld(ld),.adj_count(adj_HT));

assign reset = (( minTens == 4'b0101) &&( secTens == 4'b0101) && ( minUnits ==4'b1001 ) &&(secUnits ==4'b1001) && (HourUnits == 4'b0011) &&( HourTens ==4'b0010))? 1:0;

ClockDivider #(50000000)C2( .clk(clk),.rst(rst), .clk_out(c_out2));

assign dot = c_out2;

endmodule
