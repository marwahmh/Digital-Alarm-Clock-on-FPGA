`timescale 1ns / 1ps

module Main( input en, BTNC, BTNU,BTND,BTNR,BTNL,rst,clk, output  [6:0] segments, output [3:0] anode_active,output [3:0] leds, output dotO, led_alarm );
wire [3:0]  HU_clk , HT_clk ,MU_clk, MT_clk, HU_alarm,HT_alarm, MU_alarm , MT_alarm ;
reg [3:0] HT_reg, HU_reg ,MT_reg, MU_reg;
wire RingNow;
wire  [3:0] MT, MU ,HU, HT,SU,ST;
wire c_out;
wire[1:0] sel;
wire [3:0] to_disp, to_disp_alarm, to_disp_clk;
wire U,D,L,R,C;
wire dot_adj , dot_clk;
wire dot;
wire count_sel;

wire ld;
wire sel_clk;
wire enn,enn2;
reg off_led;
integer an =0 ;
reg state, nextstate;
wire enclk_H , enclk_M, enalarm_H , enalarm_M ;
wire aa;
wire bb , clk_ledalarm;

always @(posedge clk or posedge rst ) begin 
if (!rst)
if ( enalarm_H | enalarm_M) begin
 HT_reg <= HT_alarm;
  HU_reg <= HU_alarm;
  MT_reg <= MT_alarm;
  MU_reg <= MU_alarm;
end
end




assign aa =( ((U|D|R|L)  && sel_clk ) );
always @ (posedge clk or posedge rst )begin
if(rst )
state<= 0;
else
state<= nextstate;
end

always @ ( aa or state ) begin
case (state)
0:
case(aa)
0: nextstate =0;
1: nextstate =1;
endcase
1: 
case(aa)
0: nextstate = 1;
1: nextstate = 1;
endcase

endcase

case(enalarm_H | enalarm_M ) 
0:nextstate =0;
endcase

end

assign bb = (state ==1);

reg bkk;
ClockDivider #(50000000)C2( .clk(clk),.rst(rst), .clk_out(clk_ledalarm));
assign RingNow = (HU_reg ==HU && HT_reg ==HT&& MU_reg ==MU&& MT_reg==MT)?   1:(( bb&& enn )| enn2 )?0:1;
assign led_alarm = ( RingNow && sel_clk && ~( HT_reg==0 &&  HU_reg==0 &&  MT_reg==0&&  MU_reg==0)  ) ? clk_ledalarm : 0 ;

always @(posedge clk )
begin
if(RingNow)
    if((U|D|R|L))
        bkk = 0;
     else bkk =1;
else bkk = 0;
end
assign enn = HT_reg <HT | ( HT_reg ==HT &&  HU_reg <HU ) |( HT_reg ==HT &&  HU_reg==HU && MT_reg <MT ) |( HT_reg ==HT &&  HU_reg ==HU && MT_reg ==MT && MU_reg < MU ) ;
assign enn2 = HT_reg >HT | ( HT_reg ==HT &&  HU_reg >HU ) |(HT_reg ==HT &&  HU_reg ==HU && MT_reg >MT ) |( HT_reg ==HT &&  HU_reg ==HU && MT_reg ==MT && MU_reg > MU ) ;


assign dot = (sel_clk) ?  dot_clk:dot_adj ; 
//end
debouncer2S dooodoo (BTNC,  clk, rst,  C);
push_det p2( BTNU , clk , rst, U);
push_det p3( BTND , clk , rst, D);
push_det p4( BTNL , clk , rst, L);
push_det p5( BTNR , clk , rst, R);

alarm a( U ,D , R, L,~sel_clk,rst,clk,  HT_alarm,HU_alarm, MT_alarm , MU_alarm  , leds,dot_adj,enclk_H , enclk_M, enalarm_H , enalarm_M  ); //generates alarm values

BinaryCounter #(1,2) state_sel  (.en(C),.reset(rst),.clk(clk),.count ( count_sel) , .ld(0),.adj_count(0));

assign sel_clk = ( count_sel == 0 ) ? 1 : 0 ;
assign ld = (count_sel == 0 ) ? 0 : (enclk_H | enclk_M ) ? 1:0;

digital_clock b(  clk,rst,sel_clk ,ld, HT_alarm , HU_alarm , MT_alarm, MU_alarm , MT, ST ,  MU , SU ,HU, HT,dot_clk); // the last 6 are wires

ClockDivider #(100000)C1( .clk(clk),.rst(rst), .clk_out(c_out));
BinaryCounter  #(2,4) two_c (.en(1),.reset(rst),.clk(c_out),.count(sel),.ld(0),.adj_count(0));
mux4to1 mux1 ( HT ,HU,MT,MU,sel,to_disp_clk); // clock mux

mux4to1 mux2 (  HT_alarm , HU_alarm ,MT_alarm, MU_alarm, sel,to_disp_alarm); //alarm mux

mux2to1 mux3  (to_disp_clk , to_disp_alarm , ~sel_clk ,to_disp);  //selector ??
sevenseg_proc display (sel,to_disp,dot, dotO, segments,anode_active);


endmodule
