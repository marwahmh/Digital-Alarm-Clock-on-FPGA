//`timescale 1ns / 1ps

`timescale 1ns / 1ps

module BinaryCounter #(parameter x=4, n =10)( adj_count,en,reset,clk,count,ld );
input en,reset, clk,ld;
input [x-1:0] adj_count;
output reg [x-1:0] count;


always @ (posedge clk , posedge reset) begin
if(reset)
count<=0;
else 
if(en) 
    if (ld) 
    count <= adj_count;
    else    
        if(count<n-1) 
        count <=count+1;
        else
        count <= 0;
       
end


endmodule
