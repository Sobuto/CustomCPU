`timescale 1ns/1ps
module Execute(clk, rst, OpCode, HardCode, LdEnable, RsData, RtData, RdData, RdEnable, ImmdEnable, Branch, AddrEnable, Immd, Flush , Result, Addr, oRdEnable, oAddrEnable, NOP, Flush_in);

input clk, rst, Flush_in;
input [1:0] OpCode; //00-nothing, 01-ADD, 10-SUB, 11-SH
input [1:0] HardCode; //00-AND, 01-MVN (NOT), 10-OR, 11-XOR
input LdEnable;
input [31:0] RsData, RtData, RdData;
input RdEnable, ImmdEnable, AddrEnable;
input [2:0] Branch;
input [19:0] Immd;
input NOP;

output Flush;
output [31:0] Result;
output [31:0] Addr;
output oRdEnable, oAddrEnable;

wire [31:0] ResultTemp;
wire B0, B1, B2;

//ALU
ALU ALU(
        .OpCode(OpCode[1:0]),
        .HardCode(HardCode[1:0]),
        .ImmdEnable(ImmdEnable),
        .Branch(Branch[2:0]),
        .Immd(Immd[19:0]),
        .RsData(RsData[31:0]),
        .RtData(RtData[31:0]),
        .RdData(RdData[31:0]),
        .Result(ResultTemp[31:0]),
        .LdEnable(LdEnable),
        .RdEnable(RdEnable),
        .AddrEnable(AddrEnable),
        .NOP(NOP)
        );
        
//Result
assign Result = ((AddrEnable)&&(!RdEnable))? RdData[31:0] : ResultTemp[31:0];

//Address
assign Addr = ((AddrEnable)&&(!RdEnable))? ResultTemp[31:0] : Result[31:0];

//Branch taken, B0 - Negative, B1 - Zero, B2 - Positive
assign B0 = (Branch[2] && Result [31]) ? 1'b1 : 1'b0;
assign B1 = (Branch[1] && (Result[31:0] == 0)) ? 1'b1 : 1'b0;
assign B2 = (Branch[0] && (Result[31:0] > 0)) ? 1'b1 : 1'b0;
assign Flush = (B0 || B1 || B2);

//Enables
assign oRdEnable = (~Flush_in) && RdEnable;
assign oAddrEnable = (~Flush_in) && AddrEnable;



endmodule
