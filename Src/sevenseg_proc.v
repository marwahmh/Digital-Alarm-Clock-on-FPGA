`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module sevenseg_proc(
input [1:0]led,
input [3:0] x, input  dot , output reg dotO,
output reg [0:6] segments,
output reg [3:0] anode_active);

always @ (x,led) begin

        case (x)
        4'b0000: segments = 7'b0000001 ;
        4'b0001: segments = 7'b1001111 ;
        4'b0010:segments = 7'b0010010 ;
        4'b0011:segments = 7'b0000110 ;
        4'b0100:segments = 7'b1001100 ;
        4'b0101:segments = 7'b0100100 ;
        4'b0110:segments = 7'b0100000 ;
        4'b0111:segments = 7'b0001111 ;
        4'b1000:segments = 7'b0000000 ;
        4'b1001:segments = 7'b0000100 ;

        endcase
        
        case(led)
        2'b11 : begin 
        anode_active = 4'b1110; 
        dotO =1; end
        2'b10: begin 
        anode_active = 4'b1101;
        dotO=1;
  
        end
        2'b01: begin 
        anode_active = 4'b1011;
        dotO = ~dot;
        end
        2'b00:begin 
        anode_active = 4'b0111;
        dotO =1;
        end
        endcase

end



endmodule
