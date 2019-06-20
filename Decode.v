`timescale 1ns/1ps
module Decode(clk, rst, Instruction, Rd, OpCode, HardCode, LdEnable, RdData, RsData, RtData, RdEnable, ImmdEnable, Branch, AddrEnable, Immd, NOP, Stall, Result, RdIn, RdEnIn);

input clk, rst;
input [31:0] Result;
input [3:0] RdIn;
input RdEnIn;
input [31:0] Instruction;

output [3:0] Rd;
output reg [1:0] OpCode;//00-nothing, 01-ADD, 10-SUB, 11-SH
output reg [1:0] HardCode; //00-AND, 01-MVN (NOT), 10-OR, 11-XOR
output reg LdEnable; //1-Load, 0-Store
output [31:0] RsData, RtData, RdData;
output reg RdEnable, ImmdEnable, AddrEnable;
output reg [2:0] Branch;
output [19:0] Immd;
output reg NOP;
output Stall;

parameter NOPER = 4'b0000;
parameter LDS = 4'b0001;
parameter STR = 4'b0010;
parameter LDI = 4'b0011;
parameter B = 4'b0100;
parameter ADDS = 4'b1000;
parameter ADDI = 4'b1001;
parameter AND = 4'b1010;
parameter MVN = 4'b1011;
parameter SH = 4'b1100;
parameter SUB = 4'b1101;
parameter OR = 4'b1110;
parameter XOR = 4'b1111;

assign Immd = {Instruction[19:0]};

always@(*) begin
      RdEnable = 1'b0;
      AddrEnable = 1'b0;
      ImmdEnable = 1'b0;
      LdEnable = 1'b0;
      Branch = 1'b0;
      OpCode = 2'b00;
      HardCode = 2'bxx;
      NOP = 1'b1;
case (Instruction[31:28])
   NOPER: begin
      RdEnable = 1'b0;
      AddrEnable = 1'b0;
      ImmdEnable = 1'b0;
      LdEnable = 1'b0;
      Branch = 3'b000;
      OpCode = 2'b00;
      HardCode = 2'bxx;
      NOP = 1'b1;
      end
   LDS: begin
      RdEnable = 1'b1;
      AddrEnable = 1'b1;
      ImmdEnable = 1'b1;
      LdEnable = 1'b1;
      Branch = 3'b0;
      OpCode = 2'b00;
      HardCode = 2'bxx;
      NOP = 1'b0;
      end
   STR: begin
      RdEnable = 1'b0;
      AddrEnable = 1'b1;
      ImmdEnable = 1'b1;
      LdEnable = 1'b0;
      Branch = 3'b000;
      OpCode = 2'b00;
      HardCode = 2'bxx;
      NOP = 1'b0;
      end
   LDI: begin
      RdEnable = 1'b1;
      AddrEnable = 1'b0;
      ImmdEnable = 1'b1;
      LdEnable = 1'b1;
      Branch = 3'b000;
      OpCode = 2'b00;
      HardCode = 2'bxx;
      NOP = 1'b0;
      end
   B: begin
      RdEnable = 1'b0;
      AddrEnable = 1'b0;
      ImmdEnable = 1'b1;
      LdEnable = 1'b0;
      Branch = (Instruction[27:25]);
      OpCode = 2'b00;
      HardCode = 2'bxx;
      NOP = 1'b1;
      end
   ADDS: begin
      RdEnable = 1'b1;
      AddrEnable = 1'b0;
      ImmdEnable = 1'b0;
      LdEnable = 1'b0;
      Branch = 3'b000;
      OpCode = 2'b01;
      HardCode = 2'bxx;
      NOP = 1'b0;
      end
   ADDI: begin
      RdEnable = 1'b1;
      AddrEnable = 1'b0;
      ImmdEnable = 1'b1;
      LdEnable = 1'b0;
      Branch = 3'b000;
      OpCode = 2'b01;
      HardCode = 2'bxx;
      NOP = 1'b0;
      end
   AND: begin
      RdEnable = 1'b1;
      AddrEnable = 1'b0;
      ImmdEnable = 1'b0;
      LdEnable = 1'b0;
      Branch = 3'b000;
      OpCode = 2'b00;
      HardCode = 2'b00;
      NOP = 1'b0;
      end
   MVN: begin
      RdEnable = 1'b1;
      AddrEnable = 1'b0;
      ImmdEnable = 1'b0;
      LdEnable = 1'b0;
      Branch = 3'b000;
      OpCode = 2'b00;
      HardCode = 2'b01;
      NOP = 1'b0;
      end
   SH: begin
      RdEnable = 1'b1;
      AddrEnable = 1'b0;
      ImmdEnable = 1'b1;
      LdEnable = 1'b0;
      Branch = 3'b000;
      OpCode = 2'b11;
      HardCode = 2'bxx;
      NOP = 1'b0;
      end
   SUB: begin
      RdEnable = 1'b1;
      AddrEnable = 1'b0;
      ImmdEnable = 1'b0;
      LdEnable = 1'b0;
      Branch = 3'b000;
      OpCode = 2'b10;
      HardCode = 2'bxx;
      NOP = 1'b0;
      end
   OR: begin
      RdEnable = 1'b1;
      AddrEnable = 1'b0;
      ImmdEnable = 1'b0;
      LdEnable = 1'b0;
      Branch = 3'b000;
      OpCode = 2'b00;
      HardCode = 2'b10;
      NOP = 1'b0;
      end
   XOR: begin
      RdEnable = 1'b1;
      AddrEnable = 1'b0;
      ImmdEnable = 1'b0;
      LdEnable = 1'b0;
      Branch = 3'b000;
      OpCode = 2'b00;
      HardCode = 2'b11;
      NOP = 1'b0;
      end
   default: begin
      RdEnable = 1'b0;
      AddrEnable = 1'b0;
      ImmdEnable = 1'b0;
      LdEnable = 1'b0;
      Branch = 3'b000;
      OpCode = 2'b00;
      HardCode = 2'bxx;
      NOP = 1'b1;
      end    
endcase
end

//Register File
Register Register(
						.clk(clk),
						.rst(rst),
						.Result(Result[31:0]),
						.RdIn(RdIn[3:0]),
						.RdEnIn(RdEnIn),
						.Rd(Instruction[27:24]),
						.Rs(Instruction[23:20]),
						.Rt(Instruction[19:16]),
						.RdData(RdData[31:0]),
						.RsData(RsData[31:0]),
						.RtData(RtData[31:0]),
						.Stall(Stall),
						.OpCode(Instruction[31:28])
						);


endmodule
