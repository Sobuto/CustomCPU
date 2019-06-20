`timescale 1ns/1ps
module DElatch (clk, rst, dRd, eRd, dOpCode, eOpCode, dHardCode, eHardCode, dLdEnable, eLdEnable, dRsData, eRsData, dRtData, eRtData, dRdData, eRdData, dRdEnable, eRdEnable, dImmdEnable, eImmdEnable, dBranch, eBranch, dAddrEnable, eAddrEnable, dImmd, eImmd, dNOP, eNOP, Stall);

input clk, rst, Stall;
input dLdEnable, dRdEnable, dImmdEnable, dAddrEnable, dNOP;
input [3:0] dRd;
input [1:0] dOpCode, dHardCode;
input [2:0] dBranch;
input [19:0] dImmd;
input [31:0] dRsData, dRtData, dRdData;

output eLdEnable, eRdEnable, eImmdEnable, eAddrEnable, eNOP;
output [3:0] eRd;
output [1:0] eOpCode, eHardCode;
output [2:0] eBranch;
output [19:0] eImmd;
output [31:0] eRsData, eRtData, eRdData;

reg LdEnable, RdEnable, ImmdEnable, AddrEnable, NOP;
reg [1:0] OpCode, HardCode;
reg [2:0] Branch;
reg [3:0] Rd;
reg [19:0] Immd;
reg [31:0] RsData, RtData, RdData;

assign eLdEnable = (Stall) ? 0 : LdEnable;
assign eRdEnable = (Stall) ? 0 : RdEnable;
assign eImmdenable = (Stall) ? 0 : ImmdEnable;
assign eAddrEnable = (Stall) ? 0 : AddrEnable;
assign eNOP = (Stall) ? 1 : NOP;
assign eOpCode = (Stall) ? 2'b00 : OpCode;
assign eHardCode = (Stall) ? 2'b00 : HardCode;
assign eBranch = (Stall) ? 3'b000 : Branch;
assign eRd = (Stall) ? 4'b0000 : Rd;
assign eImmd = (Stall) ? 19'h00000 : Immd;
assign eRsData = (Stall) ? 32'h00000000 : RsData;
assign eRtData = (Stall) ? 32'h00000000 : RtData;
assign eRdData = (Stall) ? 32'h00000000 : RdData;     

always @(posedge clk, posedge rst) begin
	if (rst) begin
		LdEnable = 0;
		RdEnable = 0;
		ImmdEnable = 0;
		AddrEnable = 0;
		NOP = 1;
		OpCode = 2'b00;
		HardCode = 2'b00;
		Branch = 3'b000;
		Rd = 4'b0000;
		Immd = 19'h00000;
		RsData = 32'h00000000;
		RtData = 32'h00000000;
		RdData = 32'h00000000;
		end
	else if (Stall) begin
		LdEnable = LdEnable;
		RdEnable = RdEnable;
		ImmdEnable = ImmdEnable;
		AddrEnable = AddrEnable;
		NOP = NOP;
		OpCode = OpCode;
		HardCode = HardCode;
		Branch = Branch;
		Rd = Rd;
		Immd = Immd;
		RsData = RsData;
		RtData = RtData;
		RdData = RdData;
		end
	else begin
		LdEnable = dLdEnable;
		RdEnable = dRdEnable;
		ImmdEnable = dImmdEnable;
		AddrEnable = dAddrEnable;
		NOP = dNOP;
		OpCode = dOpCode;
		HardCode = dHardCode;
		Branch = dBranch;
		Rd = dRd;
		Immd = dImmd;
		RsData = dRsData;
		RtData = dRtData;
		RdData = dRdData;
		end
end

endmodule
