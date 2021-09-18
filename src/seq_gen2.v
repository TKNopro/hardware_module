module seq_gen2(
  input           i__clk,
  input           i_resetn,
  output          o_seq
);

  reg [7:0]       cnt0;
  reg [7:0]       cnt1;
  reg             s_seq;

  always @(posedge i_clk or negedge i_resetn) begin 
    if(!i_resetn) begin 
      cnt0  <=  8'd0;
      cnt1  <=  8'd1;
      s_seq <=  1'b0;
    end
    else begin  
      if(cnt1 > 8'd0) begin 
        s_seq <=  1'b1;
        cnt1  <=  cnt1 - 1'b1;
      end
      else begin
        cnt1  <=  cnt0;
        cnt0  <=  cnt0 + 1'b1;
        s_seq <=  1'b0;
      end
    end
  end

  assign  o_seq = s_seq;
endmodule