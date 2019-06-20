`timescale 1ns/1ps
module EMlatch(clk, rst, eFlush, mFlush, eResult, mResult, eAddr, mAddr, eRdEnable, mRdEnable, eAddrEnable, mAddrEnable, eRd, mRd);

input clk, rst;
input eFlush, eRdEnable, eAddrEnable;
input [31:0] eResult;
input [31:0] eAddr;
input [3:0] eRd;

output mFlush, mRdEnable, mAddrEnable;
output [31:0] mResult;
output [31:0] mAddr;
output [3:0] mRd;

reg Flush, RdEnable, AddrEnable;
reg [31:0] Result;
reg [31:0] Addr;
reg [3:0] Rd;

assign mFlush = Flush;
assign mRdEnable = RdEnable;
assign mAddrEnable = AddrEnable;
assign mResult = Result;
assign mAddr = Addr;
assign mRd = Rd;


always @(posedge clk, posedge rst) begin
	if (rst) begin
		Flush = 0;
		RdEnable = 0;
		AddrEnable = 0;
		Result = 32'h00000000;
		Addr = 32'h00000000;
		Rd = 4'b0000;
		end
	else begin
		Flush = mFlush;
		RdEnable = mRdEnable;
		AddrEnable = mAddrEnable;
		Result = mResult;
		Addr = mAddr;
		Rd = eRd;
		end
end		


endmodule
