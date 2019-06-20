module MWlatch(clk, rst, mem_data, Rd, RdEn, mem_data_wb, Rd_wb, RdEn_wb);
  input clk, rst;
  input[31:0] mem_data;
  input[3:0] Rd;
  input RdEn;
  
  output[31:0] mem_data_wb;
  output[3:0] Rd_wb;
  output RdEn_wb;
  
  dff_en MEM_WB_load_data [31:0] (.d(mem_data), .q(mem_data_wb), .en(1'b1), .clk(clk), .rst(rst));
  dff_en MEM_WB_Rd [3:0] (.d(Rd), .q(Rd_wb), .en(1'b1), .clk(clk), .rst(rst));
  dff_en MEM_WB_RdEn  (.d(RdEn), .q(RdEn_wb), .en(1'b1), .clk(clk), .rst(rst));  


endmodule
