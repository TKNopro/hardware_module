module arbiter_rr #(
  parameter       DW  = 4
)(
  input           i_clk,
  input           i_rstn,
  input           i_gnt,
  input [DW-1:0]  i_req,
  output          o_req,
  output[DW-1:0]  o_gnt
);

  reg [DW-1:0]    ringcnt;
  wire[2*DW-1:0]  double_req;
  wire[2*DW-1:0]  double_gnt;

  always @(posedge i_clk or negedge i_rstn) begin 
    if(!i_rstn)
      ringcnt   <=  {{(DW-1){1'b0}},1'b1};
    else if(i_gnt & o_req)
      ringcnt   <=  {ringcnt[DW-2:0],ringcnt[DW-1]};
  end

  assign  double_req  = {i_req, i_req};
  assign  double_gnt  = double_req & ~(double_req-ringcnt);
  assign  o_gnt       = (double_req[2*DW-1:DW] | double_req[DW-1:0]) & {DW{i_req}};
  assign  o_req       = | i_req;
endmodule