module seq_gen(
  input             i_clk,
  input             i_resetn,

  output            o_seq
);

  parameter         S0  = 1'b0;
  parameter         S1  = 1'b1;

  reg               cur_state;
  reg               nxt_state;
  reg [7:0]         cnt0;
  reg [7:0]         cnt1;
  reg               s_seq;

  always @(posedge i_clk or negedge i_resetn) begin 
    if(!i_resetn)
      cur_state <=  S0;
    else 
      cur_state <=  nxt_state;
  end

  always @(*) begin
    case(cur_state)
      S0:begin
        if(cnt1 == 8'd0)
          nxt_state = S1;
        else
          nxt_state = S0;
      end

      S1:begin  
        if(cnt1 > 8'd0)
          nxt_state = S0;
      end

      default: nxt_state  = S0;
    endcase
  end

  always @(posedge i_clk or negedge i_resetn) begin 
    if(!i_resetn) begin 
      cnt0  <=  8'd1;
      cnt1  <=  8'd0;
      s_seq <=  1'b0;
    end
    else begin  
      case(nxt_state)
        S0:begin
          s_seq <=  1'b1;
          cnt1  <=  cnt1+1'b1;
        end

        S1:begin
          cnt1  <=  cnt0;
          cnt0  <=  cnt0 + 1'b1;
          s_seq <=  1'b0;
        end

        default: begin  
          s_seq <=  1'b0;
          cnt0  <=  8'd1;
          cnt1  <=  8'd0;
        end
      endcase
    end
  end

  assign  o_seq = s_seq;
endmodule