`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


module push_det( input push , clk , reset, output out );
    wire clk_out, in1,in2;
    ClockDivider #(250000) c(clk,reset,clk_out);
    sync soso (  clk , push, reset,   in1   );
    debouncer dede (in1 , clk_out,reset, in2);
    RisingEdgeDetector roso (.rst(reset),.clk(clk), .level(in2) , .tick(out));
endmodule
