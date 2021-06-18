`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module alarm ( input bt_u ,bt_d , bt_r , bt_l,en,reset ,clk, output [3:0]   HT_adj , HU_adj ,MT_adj, MU_adj  ,output reg [3:0] leds , output dot, enclk_H,enclk_M,enalarm_H,enalarm_M ); //generates alarm values
wire [1:0] count; //////////
wire en1,en2,en3,ld;
wire [3:0] adj_hu, adj_ht;
reg  enalarm_M,enclk_M,enclk_H ,enalarm_H ;
assign adj_hu = 4'b0000;
assign adj_ht = 4'b0000;
wire en_M =  enalarm_M |enclk_M ;
wire rst,rst1;

assign en1 = ( en_M && ((MU_adj==4'b1001 && bt_u) || (MU_adj == 4'b0000 && bt_d))) ? 1:0;

wire en_H = enalarm_H |enclk_H;
assign en2 = ( en_H  && ((HU_adj ==4'b1001  && bt_u )  || (HU_adj == 4'b0000 && bt_d)) )? 1:0;

 adjust_hours(en_H, reset,clk,  bt_d, bt_u,  HT_adj, HU_adj )  ;
adjust #(4,6) MT( en1, reset,clk, bt_d, bt_u, MT_adj );
adjust #(4,10) MU (en_M, reset,clk,  bt_d, bt_u,MU_adj );
assign rst = (  ( (HU_adj == 4'b0100) && ( HT_adj==4'b0010) ) |(  (HU_adj == 4'b1001) &&  ( HT_adj==4'b0010)) ) ? 1:0;

adjust_pos #(2) pos (clk, en, reset, bt_r, bt_l ,count); //  up' / down

always@(*) begin
if (en) begin
case (count)
2'b00: begin
enalarm_M =0;
enclk_M =0;
enclk_H =1;
enalarm_H = 0;

end
2'b01: begin
enalarm_M =0;
enclk_M =1;
enclk_H =0;
enalarm_H = 0;
 end
2'b10: begin
enalarm_M =0;
enclk_M =0;
enclk_H =0;
enalarm_H = 1;
 end
2'b11: begin
enalarm_M =1;
enclk_M =0;
enclk_H =0;
enalarm_H = 0;
 end

default : begin
enalarm_M =0;
enclk_M =0;
enclk_H =1;
enalarm_H = 0;
end
endcase

 leds[0] = enalarm_M;
 leds[1] = enalarm_H;
 leds[2] = enclk_M;
 leds[3] = enclk_H;

end
else 

if(~en) leds=4'b0000;
end


assign dot =1;

endmodule