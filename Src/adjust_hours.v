`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/19/2019 10:38:33 PM
// Design Name: 
// Module Name: adjust_hours
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module adjust_hours(en, reset,clk,  bt_d, bt_u,  HT_adj, HU_adj )  ;
    input en,reset,clk,bt_d,bt_u;
//     reg [3:0] HT_clk, HU_clk;
   output [3:0]  HT_adj, HU_adj;
   wire [3:0] HT,HU;
    assign en2 = ( en  && ((HU ==4'b1001  && bt_u )  || (HU == 4'b0000 && bt_d)) )? 1:0;
    adjust #(4,10) HU_mod( en , reset|rs,clk,  bt_d, bt_u,  HU );
    adjust #(4,3) HT_mod  (en2  , reset|rs,clk,  bt_d, bt_u,HT );
//    always @ ( posedge clk or posedge reset ) begin
//    if(!reset)
//     if ( HT == 4'b0000 && HU == 4'b0000  ) begin
//       HU_clk <= 4'b0011;
//        HT_clk <= 4'b0010;
//       end
//       else begin 
//        HU_clk <= HU;
//           HT_clk <= HT;
      //end
        
    
//    end
//    assign  HT_adj = ( HT == 4'b0000 && HU == 4'b0000 && bt_d )? HT_clk:HT;
//    assign  HU_adj =( HT == 4'b0000 && HU == 4'b0000 && bt_d )? HU_clk:HU;
assign  HT_adj= HT;
assign  HU_adj= HU;
//assign rs =  (  (HU == 4'b0100 & HT ==4'b0010  ) |  (HU == 4'b1001 & HT ==4'b0010  ))? 1:0;
assign rs =   (HU == 4'b0100 & HT ==4'b0010  ) || (HU == 4'b0000 & HT ==4'b0000 & bt_d  ) ? 1:0;
endmodule
