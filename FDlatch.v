`timescale 1ns/1ps
module FDlatch(clk, rst, fInstruction, dInstruction, fPC, dPC, Stall);

input clk, rst, Stall;
input [31:0] fInstruction;
input [9:0] fPC;

output [31:0] dInstruction;
output [9:0] dPC;

reg [31:0] Instruction;
reg [9:0] PC;

assign dInstruction = Instruction;
assign dPC = PC;      

always @(posedge clk, posedge rst) begin
	if (rst)
		Instruction = 32'h00000000;
	else if (Stall)
		Instruction = Instruction;
	else
		Instruction = fInstruction;
end
		
always @(posedge clk, posedge rst) begin
	if (rst)
		PC = 10'b0000000000;
	else if (Stall)
		PC = PC;
	else
		PC = fPC;
end		

endmodule        
