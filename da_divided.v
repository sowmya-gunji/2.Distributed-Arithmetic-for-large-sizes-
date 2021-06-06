`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/25/2020 12:41:07 PM
// Design Name: 
// Module Name: da_divided
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


module divided_da(clk,x0,x1,x2,x3,w0,w1,w2,w3,out);
input clk;
input [7:0]x0,x1,x2,x3;
input [31:0]w0,w1,w2,w3;
output reg [31:0]out;
reg [31:0]l0,l1,acc,acc_shift,lout;
reg [2:0]i;
reg w;
initial
begin
i=0;acc=0;acc_shift=0;
end
always @(posedge clk)
begin
case({x1[i],x0[i]})  //DA1 LUT
2'b00:l0=0;
2'b01:l0=w0;
2'b10:l0=w1;
2'b11:l0=w1+w0;
endcase
case({x3[i],x2[i]})  //DA2 LUT
2'b00:l1=0;
2'b01:l1=w2;
2'b10:l1=w3;
2'b11:l1=w3+w2;
endcase
lout=l0+l1;
    if(i<7)
    begin
    acc=lout+acc_shift;  //DA1
    w=acc[31];
    acc_shift=acc>>1;
    acc_shift[31]=w;
    end
    else if(i==7)
    begin
    acc=acc_shift-lout;
    out=acc;
    acc=0;acc_shift=0;
    end
    i=i+1;
end
endmodule
