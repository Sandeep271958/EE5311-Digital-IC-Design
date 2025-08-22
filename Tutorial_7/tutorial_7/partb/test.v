// sch_path: /home/ee22b074/ee5311/tutorial_7/test.sch
module test
(
  output wire [15:0] sum,
  output wire Cout,
  input wire [15:0] a,
  input wire [15:0] b,
  input wire cin
);
wire [14:0] carry;

  fulladder fa0(a[0], b[0], cin, sum[0], carry[0]);
  fulladder fa1(a[1], b[1], carry[0], sum[1], carry[1]);
  fulladder fa2(a[2], b[2], carry[1], sum[2], carry[2]);
  fulladder fa3(a[3], b[3], carry[2], sum[3], carry[3]);
  fulladder fa4(a[4], b[4], carry[3], sum[4], carry[4]);
  fulladder fa5(a[5], b[5], carry[4], sum[5], carry[5]);
  fulladder fa6(a[6], b[6], carry[5], sum[6], carry[6]);
  fulladder fa7(a[7], b[7], carry[6], sum[7], carry[7]);
  fulladder fa8(a[8], b[8], carry[7], sum[8], carry[8]);
  fulladder fa9(a[9], b[9], carry[8], sum[9], carry[9]);
  fulladder fa10(a[10], b[10], carry[9], sum[10], carry[10]);
  fulladder fa11(a[11], b[11], carry[10], sum[11], carry[11]);
  fulladder fa12(a[12], b[12], carry[11], sum[12], carry[12]);
  fulladder fa13(a[13], b[13], carry[12], sum[13], carry[13]);
  fulladder fa14(a[14], b[14], carry[13], sum[14], carry[14]);
  fulladder fa15(a[15], b[15], carry[14], sum[15], Cout);
endmodule
module fulladder
(
  input wire A,
  output wire S,
  input wire B,
  output wire Cout,
  input wire Cin
);
assign S = A ^ B ^ Cin;
assign Cout = (A & B) | (B & Cin) | (Cin & A);
// noconn a[15:0]
// noconn b[15:0]
// noconn cin
// noconn sum[15:0]
// noconn Cout
endmodule
