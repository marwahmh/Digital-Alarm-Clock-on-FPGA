`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module D_flipflip ( input clk , reset , d , output reg q ) ;
always @ ( posedge clk or posedge reset )
begin
if (!reset)
q <= d;
end
endmodule

module debouncer2S(input in1, input clk, reset, output out);
wire c_out;
wire in2,in3;
ClockDivider #(5000000)C1111( .clk(clk),.rst(reset), .clk_out(c_out));
reg [19:0] q;
initial begin q = 0; end
always@(posedge c_out)
begin
q[0] <= in2 ; 
q[1] <= q[0];
q[2] <= q[1];
q[3] <= q[2];
q[4] <= q[3];
q[5] <= q[4];
q[6] <= q[5];
q[7] <= q[6];
q[8] <= q[7];
q[9] <= q[8];
q[10] <= q[9];
q[11] <= q[10];
q[12] <= q[11];
q[13] <= q[12];
q[14] <= q[13];
q[15] <= q[14];
q[16] <= q[15];
q[17] <=  q[16];
q[18] <= q[17];
q[19] <=  q[18];

end



assign in3= &q;

sync sosoooo (clk , in1, reset, in2);
RisingEdgeDetector rosooooo (.rst(reset),.clk(clk), .level(in3) , .tick(out));

endmodule
