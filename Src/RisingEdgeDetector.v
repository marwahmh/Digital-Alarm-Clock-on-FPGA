`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


module RisingEdgeDetector (
     input clk,
    input rst,
    input level,
    output tick
    );
    parameter [1:0] a= 2'b00, b = 2'b01, c = 2'b10;
   reg [1:0] state, nextState;
   always @ (*) begin
   case (state)
   a: if (level) nextState =b;
   else nextState = a;
   b: if (level) nextState = c;
   else nextState = a;
   c: if (level) nextState = c;
   else nextState = a;
   default: nextState = a;
   endcase
   end
   always @ (posedge clk or posedge rst) 
   begin
   if(rst) state <= a;
   else state <= nextState;
   end
   
   assign tick =(state==b);
   endmodule

