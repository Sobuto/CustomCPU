module Memory(clk, rst, mResult, mAddr, mRdEnable, mAddrEnable, load_data);
  input clk,rst;
  input [31:0] mResult, mAddr;
  input mRdEnable, mAddrEnable;
  output [31:0] load_data;
  
  wire [31:0] dout;
  wire wea;
  
  assign wea = (mAddrEnable)&&(!mRdEnable);
  
DataMem DataMem(
				.clka(clk),
				.dina(mResult),
				.addra(mAddr),
				.wea(wea),
				.douta(dout[31:0])
	);
	
assign load_data = (mRdEnable && mAddrEnable) ? dout[31:0] : mResult[31:0];

	
endmodule
