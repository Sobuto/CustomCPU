`timescale 1ns/1ps
module Fetch(clk, rst, PCrd, PC, Instruction, PCold, Flush);

input clk, rst, Flush;
input [9:0] PCrd, PCold;

output [9:0] PC;
output [31:0] Instruction;

wire [9:0] PC0;

//Increment the PC
assign PC0 = PCold + 4;

//Change the PC on branches
assign PC = (Flush) ? PCrd[9:0] : PC0[9:0];

//Instruction Memory
InstMem InstMem(
				.clka(clk),
				.addra(PCold [9:0]),
				.douta(Instruction[31:0])
				);

endmodule
