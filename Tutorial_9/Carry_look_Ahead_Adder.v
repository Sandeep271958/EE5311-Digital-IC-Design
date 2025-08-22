module carry_look_ahead
(
  input wire [15:0] A,
  input wire [15:0] B,
  output wire [15:0] S,
  input wire Cin,
  output wire Cout
);
wire [15:0] P, G;
    	wire [16:0] C;

   	assign C[0] = Cin;

    	genvar i;
    	generate
		for (i = 0; i < 16; i = i + 1) begin
	    		pg_gen pg_inst (.a(A[i]), .b(B[i]), .p(P[i]), .g(G[i]));
	    		assign C[i+1] = G[i] | (P[i] & C[i]);
	    		assign S[i] = P[i] ^ C[i];
		end
    	endgenerate

	assign Cout = C[16];
    	

endmodule


	


// noconn Cin
// noconn B[15:0]
// noconn A[15:0]
// noconn S[15:0]
// noconn Cout
module pg_gen (input a, input b, output p, output g);

	assign p = a ^ b;
	assign g = a & b;

endmodule