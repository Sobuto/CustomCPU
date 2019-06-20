`timescale 1ns/1ps
module proc(clk, rst);

input clk, rst;

wire [31:0] fInstruction, dInstruction, dRsData, dRtData, dRdData;
wire [31:0] eRsData, eRtData, eRdData, eResult, mResult, eAddr, mAddr;
wire [9:0] ePC, mPC, dPC, fPC;
wire [19:0] dImmd, eImmd;
wire [3:0] dRd, eRd, mRd;
wire [2:0] dBranch, eBranch;
wire [1:0] dOpCode, eOpCode, dHardCode, eHardCode;
wire mHalt, dLdEnable, dImmdEnable, dAddrEnable, dNOP, dRdEnable, eFlush;
wire eHalt, eNOP, eAddrEnable, eImmdEnable, eLdEnable, eRdenable, mFlush;
wire eoAddrEnable, eoRdEnable, mAddrEnable, mRdEnable, dStall, eStall, Stall;
//mem,wb
wire [31:0] wResult, moResult;
wire [3:0] wRd;
wire wRdEnable;



//Fetch
Fetch Fetch(
           .clk(clk),
           .rst(rst),
           .PCrd({mAddr[9:0]}),
           .PC(fPC[9:0]),
           .Instruction(fInstruction[31:0]),
           .PCold(dPC[9:0]),
           .Flush(mFlush)
           );

//Fetch to Decode latch
FDlatch FDlatch(
           .clk(clk),
           .rst(rst),
           .fInstruction(fInstruction[31:0]),
           .dInstruction(dInstruction[31:0]),
           .fPC(fPC[9:0]),
           .dPC(dPC[9:0]),
           .Stall(Stall)
           );

//Decode
Decode Decode(
           .clk(clk),
           .rst(rst),
           .Instruction(dInstruction[31:0]),
           .Rd(dRd[3:0]),
           .OpCode(dOpCode[1:0]),
           .HardCode(dHardCode[1:0]),
           .LdEnable(dLdEnable),
           .RsData(dRsData[31:0]),
           .RtData(dRtData[31:0]),
           .RdData(dRdData[31:0]),
           .RdEnable(dRdEnable),
           .ImmdEnable(dImmdEnable),
           .Branch(dBranch[2:0]),
           .AddrEnable(dAddrEnable),
           .Immd(dImmd[19:0]),
           .NOP(dNOP),
           .Stall(Stall),
           .Result(wResult[31:0]), //WB results
           .RdIn(wRd[3:0]), //WB results
           .RdEnIn(wRdEnable) //WB results
             );

//Decode to Execute latch
DElatch DElatch(
           .clk(clk),
           .rst(rst),
           .dRd(dRd[3:0]),
           .eRd(eRd[3:0]),
           .dOpCode(dOpCode[1:0]),
           .eOpCode(eOpCode[1:0]),
           .dHardCode(dHardCode[1:0]),
           .eHardCode(eHardCode[1:0]),
           .dLdEnable(dLdEnable),
           .eLdEnable(eLdEnable),
           .dRsData(dRsData[31:0]),
           .eRsData(eRsData[31:0]),
           .dRtData(dRtData[31:0]),
           .eRtData(eRtData[31:0]),
           .dRdData(dRdData[31:0]),
           .eRdData(eRdData[31:0]),
           .dRdEnable(dRdEnable),
           .eRdEnable(eRdEnable),
           .dImmdEnable(dImmdEnable),
           .eImmdEnable(eImmdEnable),
           .dBranch(dBranch[2:0]),
           .eBranch(eBranch[2:0]),
           .dAddrEnable(dAddrEnable),
           .eAddrEnable(eAddrEnable),
           .dImmd(dImmd[19:0]),
           .eImmd(eImmd[19:0]),
           .dNOP(dNOP),
           .eNOP(eNOP),
           .Stall(Stall)
           );

//Execute
Execute Execute(
           .clk(clk),
           .rst(rst),
           .OpCode(eOpCode[1:0]),
           .HardCode(eHardCode[1:0]),
           .LdEnable(eLdEnable),
           .RsData(eRsData[31:0]),
           .RtData(eRtData[31:0]),
           .RdData(eRdData[31:0]),
           .RdEnable(eRdEnable),
           .ImmdEnable(eImmdEnable),
           .Branch(eBranch[2:0]),
           .AddrEnable(eAddrEnable),
           .Immd(eImmd[19:0]),
           .Flush(eFlush),
           .Result(eResult[31:0]),
           .Addr(eAddr[31:0]),
           .oRdEnable(eoRdEnable),
           .oAddrEnable(eoAddrEnable),
           .NOP(eNOP),
           .Flush_in(mFlush)
           );

//Execute to Memory latch
EMlatch EMlatch(
           .clk(clk),
           .rst(rst),
           .eFlush(eFlush),
           .mFlush(mFlush),
           .eResult(eResult[31:0]),
           .mResult(mResult[31:0]),
           .eAddr(eAddr[31:0]),
           .mAddr(mAddr[31:0]),
           .eRdEnable(eoRdEnable),
           .mRdEnable(mRdEnable),
           .eAddrEnable(eoAddrEnable),
           .mAddrEnable(mAddrEnable),
			  .eRd(eRd[3:0]),
			  .mRd(mRd[3:0])
				);

//Memory
Memory Memory(
				.clk(clk),
				.rst(rst),
				.mResult(mResult[31:0]),
				.mAddr(mAddr[31:0]),
				.mRdEnable(mRdEnable),
				.mAddrEnable(mAddrEnable),
				.load_data(moResult[31:0])
           );

//Memory to Writeback latch
MWlatch MWlatch(
           .clk(clk),
			  .rst(rst),
			  .mem_data(moResult[31:0]),
			  .Rd(mRd[3:0]),
			  .RdEn(mRdEnable),
			  .mem_data_wb(wResult[31:0]),
			  .Rd_wb(wRd[3:0]),
			  .RdEn_wb(wRdEnable)
           );

endmodule


















