`timescale 1ns/1ps 
module ALU(OpCode, HardCode, ImmdEnable, Branch, Immd, RsData, RtData, RdData, Result, LdEnable, RdEnable, AddrEnable, NOP);
    
input [1:0] OpCode; //00-nothing, 01-ADD, 10-SUB, 11-SH
input [1:0] HardCode; //00-AND, 01-MVN (NOT), 10-OR, 11-XOR
input ImmdEnable;
input [2:0] Branch;
input [19:0] Immd;
input [31:0] RsData, RtData, RdData;
input LdEnable, RdEnable, AddrEnable;
input NOP;

output [31:0] Result;   

wire [31:0] OpResult0, OpResult;
wire [31:0] HResult0, HResult1, HResult;
wire [31:0] Result0, Result1;
wire [31:0] RsValue, RtValue;
wire [31:0] RdShift, RdSub, RdAdd;

//RsData
assign RsValue = (ImmdEnable) ? (RsData[31:0] + Immd[19:0]) : RsData[31:0];
//RtData
assign RtValue = (AddrEnable || ImmdEnable) ? 32'h00000000 : RtData[31:0];

//RdShift
assign RdShift = RdData << RsValue;

//RdSub
assign RdSub = RsData[31:0] - RtValue[31:0];

//RdAdd
assign RdAdd = RsValue[31:0] + RtValue[31:0];


//OpCode       //Shift and Subtract
assign OpResult0 = (OpCode == 2'b11) ? RdShift[31:0] : RdSub[31:0];
               //ADD
assign OpResult = ((OpCode == 2'b01) ) ? RdAdd[31:0] : OpResult0[31:0]; 


//HardCode     //XOR and OR
assign HResult1 = (HardCode == 2'b11) ? (RsData[31:0] | RtData[31:0]) : (RsData[31:0] ^ RtData[31:0]);
               //AND and NOT
assign HResult0 = (HardCode == 2'b00) ? (RsData[31:0] & RtData[31:0]) : (~RsData[31:0]);

assign HResult = (HardCode[1] == 1'b1) ? HResult1[31:0] : HResult0[31:0];


//FINAL SOLUTION
assign Result0 = (OpCode == 2'b00) ? HResult[31:0] : OpResult[31:0];
assign Result1 = (((ImmdEnable)||(AddrEnable)) && (OpCode == 2'b00)) ? RsValue[31:0] : Result0[31:0];
assign Result = (NOP && (Branch == 3'b000)) ? {32'h00000000} : Result1[31:0];


 
endmodule
