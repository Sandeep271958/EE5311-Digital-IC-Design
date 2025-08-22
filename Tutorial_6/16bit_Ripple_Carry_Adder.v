// sch_path: /home/ee22b045/ee5311/tutorial_7/bitadder.sch
module bitadder
(
  output wire [15:0] S,
  output wire Cout,
  input wire [15:0] A,
  input wire [15:0] B,
  input wire Cin
);
wire [15:0] C;

	fulladder fa0 (.a(A[0]), .b(B[0]), .cin(Cin), .sum(S[0]), .cout(C[0]));

	genvar i;
	generate
		for (i = 1; i < 16; i = i + 1)
		begin
			fulladder fa_inst (.a(A[i]), .b(B[i]), .cin(C[i-1]), .sum(S[i]), .cout(C[i]));	
	end
	endgenerate

	assign Cout = C[15];

endmodule



// noconn Cin
// noconn B[15:0]
// noconn A[15:0]
// noconn S[15:0]
// noconn Cout
module fulladder (input a, input b, input cin, output sum, output cout);

	assign sum = a ^ b ^ cin;
	assign cout = (a & b) | (b & cin) | (a & cin);

endmodule