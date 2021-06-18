`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module adjust  #(parameter x=4,n=10)(en, reset, clk, Down, up ,count); //  up' / down     (increment and decrement) // change the lst coubt ??
input en,reset,up , Down,clk;
output reg [x-1:0] count;
//reg [n-1:0]countM;
always @ (posedge clk or posedge reset ) begin
if(reset)
count<=0;
else
if(en) begin
    if(up)
        if(count< n-1)
        count <=count+1;
        else
        count <= 0;
    else
        if(Down == 1 )
            if(count > 0)
            count <= count - 1;
            else
            count <= n-1;
end

end
endmodule

