`timescale 1ns/1ps
module Register(clk, rst, Result, RdIn, RdEnIn, Rd, Rs, Rt, RdData, RsData, RtData, Stall, OpCode);

input clk, rst;
input [31:0] Result;
input [3:0] OpCode;
input [3:0] RdIn, Rd, Rs, Rt;
input RdEnIn;

output reg [31:0] RdData, RsData, RtData;
output Stall;

reg [31:0] RsTemp, RtTemp, RdTemp;
reg [3:0] RTemp1, RTemp2, RTemp3;
reg [31:0] R0, R1, R2, R3, R4, R5, R6, R7, R8, R9;
reg [31:0] R10, R11, R12, R13, R14, R15;

wire StallRs, StallRt, OpRt, OpRs;

//RdData
always @(*) 
	case (Rd)
   4'b0000 : RdData = R0;
   4'b0001 : RdData = R1;
	4'b0010 : RdData = R2;
	4'b0011 : RdData = R3;
	4'b0100 : RdData = R4;
   4'b0101 : RdData = R5;
	4'b0110 : RdData = R6;
	4'b0111 : RdData = R7;
	4'b1000 : RdData = R8;
   4'b1001 : RdData = R9;
	4'b1010 : RdData = R10;
	4'b1011 : RdData = R11;
	4'b1100 : RdData = R12;
   4'b1101 : RdData = R13;
	4'b1110 : RdData = R14;
	4'b1111 : RdData = R15;
   default : RdData = 32'h00000000;
   endcase
	
//RsData
always @(*) 
	case (Rs)
   4'b0000 : RsData = R0;
   4'b0001 : RsData = R1;
	4'b0010 : RsData = R2;
	4'b0011 : RsData = R3;
	4'b0100 : RsData = R4;
   4'b0101 : RsData = R5;
	4'b0110 : RsData = R6;
	4'b0111 : RsData = R7;
	4'b1000 : RsData = R8;
   4'b1001 : RsData = R9;
	4'b1010 : RsData = R10;
	4'b1011 : RsData = R11;
	4'b1100 : RsData = R12;
   4'b1101 : RsData = R13;
	4'b1110 : RsData = R14;
	4'b1111 : RsData = R15;
   default : RsData = 32'h00000000;
   endcase

//RtData
always @(*) 
	case (Rt)
   4'b0000 : RtData = R0;
   4'b0001 : RtData = R1;
	4'b0010 : RtData = R2;
	4'b0011 : RtData = R3;
	4'b0100 : RtData = R4;
   4'b0101 : RtData = R5;
	4'b0110 : RtData = R6;
	4'b0111 : RtData = R7;
	4'b1000 : RtData = R8;
   4'b1001 : RtData = R9;
	4'b1010 : RtData = R10;
	4'b1011 : RtData = R11;
	4'b1100 : RtData = R12;
   4'b1101 : RtData = R13;
	4'b1110 : RtData = R14;
	4'b1111 : RtData = R15;
   default : RtData = 32'h00000000;
   endcase


//RTemps record previous destination registers to check for stalls
//RTemp1
always @(posedge clk, posedge rst) begin
	if (rst)
		RTemp1 <= 4'b0000;
	else if (RdEnIn)
		RTemp1 <= RdIn;
	else
		RTemp1 <= 4'b0000;
end
	
//RTemp2
always @(posedge clk, posedge rst) begin
	if (rst)
		RTemp2 <= 4'b0000;
	else
		RTemp2 <= RTemp1;
end
	

//RTemp3
always @(posedge clk, posedge rst) begin
	if (rst)
		RTemp3 <= 4'b0000;
	else
		RTemp3 <= RTemp2;
end	
	

//STALL
assign OpRt = ((OpCode == 4'b1000) || (OpCode == 4'b1010) || (OpCode >= 4'b1101));
assign StallRt = ((RdEnIn && OpRt) &&	((Rt==RTemp1)||(Rt==RTemp2)||(Rt==RTemp3)));

assign OpRs = ((OpCode != 4'b0000) && (OpCode != 4'b0011));
assign StallRs = ((RdEnIn && OpRs) &&	((Rs==RTemp1)||(Rs==RTemp2)||(Rs==RTemp3)));

assign Stall = StallRs || StallRt;


//R0 - Always '0'
always @(posedge clk, posedge rst) begin
	if (rst)
		R0 <= 32'h00000000;
	else
		R0 <= 32'h00000000;	
	end

//R1
always @(posedge clk, posedge rst) begin
	if (rst)
		R1 <= 32'h00000000;
	else if ((RdIn == 4'b0001)&&(RdEnIn))
		R1 <= Result;
	else
		R1 <= R1;
	end

//R2
always @(posedge clk, posedge rst) begin
	if (rst)
		R2 <= 32'h00000000;
	else if ((RdIn == 4'b0010)&&(RdEnIn))
		R2 <= Result;	
	else
		R2 <= R2;
	end

//R3
always @(posedge clk, posedge rst) begin
	if (rst)
		R3 <= 32'h00000000;
	else if ((RdIn == 4'b0011)&&(RdEnIn))
		R3 <= Result;	
	else
		R3 <= R3;
	end

//R4
always @(posedge clk, posedge rst) begin
	if (rst)
		R4 <= 32'h00000000;
	else if ((RdIn == 4'b0100)&&(RdEnIn))
		R4 <= Result;	
	else
		R4 <= R4;
	end

//R5
always @(posedge clk, posedge rst) begin
	if (rst)
		R5 <= 32'h00000000;
	else if ((RdIn == 4'b0101)&&(RdEnIn))
		R5 <= Result;	
	else
		R5 <= R5;
	end

//R6
always @(posedge clk, posedge rst) begin
	if (rst)
		R6 <= 32'h00000000;
	else if ((RdIn == 4'b0110)&&(RdEnIn))
		R6 <= Result;	
	else
		R6 <= R6;
	end

//R7
always @(posedge clk, posedge rst) begin
	if (rst)
		R7 <= 32'h00000000;
	else if ((RdIn == 4'b0111)&&(RdEnIn))
		R7 <= Result;	
	else
		R7 <= R7;
	end

//R8
always @(posedge clk, posedge rst) begin
	if (rst)
		R8 <= 32'h00000000;
	else if ((RdIn == 4'b1000)&&(RdEnIn))
		R8 <= Result;	
	else
		R8 <= R8;
	end

//R9
always @(posedge clk, posedge rst) begin
	if (rst)
		R9 <= 32'h00000000;
	else if ((RdIn == 4'b1001)&&(RdEnIn))
		R9 <= Result;	
	else
		R9 <= R9;
	end

//R10
always @(posedge clk, posedge rst) begin
	if (rst)
		R10 <= 32'h00000000;
	else if ((RdIn == 4'b1010)&&(RdEnIn))
		R10 <= Result;	
	else
		R10 <= R10;
	end

//R11
always @(posedge clk, posedge rst) begin
	if (rst)
		R11 <= 32'h00000000;
	else if ((RdIn == 4'b1011)&&(RdEnIn))
		R11 <= Result;	
	else
		R11 <= R11;
	end

//R12
always @(posedge clk, posedge rst) begin
	if (rst)
		R12 <= 32'h00000000;
	else if ((RdIn == 4'b1100)&&(RdEnIn))
		R12 <= Result;	
	else
		R12 <= R12;
	end

//R13
always @(posedge clk, posedge rst) begin
	if (rst)
		R13 <= 32'h00000000;
	else if ((RdIn == 4'b1101)&&(RdEnIn))
		R13 <= Result;	
	else
		R13 <= R13;
	end

//R14
always @(posedge clk, posedge rst) begin
	if (rst)
		R14 <= 32'h00000000;
	else if ((RdIn == 4'b1110)&&(RdEnIn))
		R14 <= Result;	
	else
		R14 <= R14;
	end

//R15
always @(posedge clk, posedge rst) begin
	if (rst)
		R15 <= 32'h00000000;
	else if ((RdIn == 4'b1111)&&(RdEnIn))
		R15 <= Result;	
	else
		R15 <= R15;
	end						
						
endmodule					
