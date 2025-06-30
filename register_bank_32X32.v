`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.06.2025 19:05:40
// Design Name: 
// Module Name: register_bank_32X32
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


module register_bank_32X32(sr1,sr2,dr,regd1,regd2,wdata,write,clk,reset);
input [4:0]sr1,sr2,dr;
input [31:0]wdata;
input write,clk,reset;
output [31:0]regd1,regd2;

reg [31:0] bank [0:31];

assign regd1=bank[sr1];
assign regd2=bank[sr2];

always @(posedge clk or posedge reset)
begin
if(reset)
begin
for(integer i=0;i<32;i=i+1)
begin
bank[i]<=0;
end
end
else if(write)
bank[dr]<=wdata;
end
endmodule
