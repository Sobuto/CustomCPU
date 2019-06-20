// D-flipflop

module dff (q, d, clk, rst);

    output         q;
    input          d;
    input          clk;
    input          rst;

    reg            state;

    assign q = state;

    always @(posedge clk) begin
      state = rst? 0 : d;
    end

endmodule
