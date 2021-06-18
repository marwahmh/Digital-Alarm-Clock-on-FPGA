`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module adjust_pos #(parameter x=2)(clk ,en, reset, right, left ,count); //  up' / down       //change the last position ??
input en,reset,right , left,clk;
output reg [x-1:0] count;
//reg [n-1:0]countM;
always @ (posedge clk or posedge reset) begin
if(reset)
count<=0;
else
    if(en)
        if(right)
            if(count < 3)
            count <=count+1;
             else
             count <= 0;
        else
        if(left)
            if(count > 0)
            count <= count - 1;
            else
            count <= 3;

end
endmodule
