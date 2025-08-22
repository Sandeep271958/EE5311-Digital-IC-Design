// sch_path: /home/ee22b074/ee5311/tutorial_7/fulladder.sch
module fulladder
(
  output wire S,
  output wire Cout,
  input wire A,
  input wire B,
  input wire Cin
);
assign S = A ^ B ^ Cin;
assign Cout = (A & B) | (B & Cin) | (Cin & A);
// noconn A
// noconn B
// noconn Cin
// noconn S
// noconn Cout
endmodule
