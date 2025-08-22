// Top-level module with clocked registers
module carrybypass_reg(
    input clk,
    input [15:0] A_in,
    input [15:0] B_in,
    input Cin_in,
    output reg [15:0] S_out,
    output reg Cout_out
);

    reg [15:0] A_reg, B_reg;
    reg Cin_reg;

    wire [15:0] S_wire;
    wire Cout_wire;

    // Instantiate the actual carry bypass adder
    carrybypass cb_adder(
        .A(A_reg),
        .B(B_reg),
        .Cin(Cin_reg),
        .Cout(Cout_wire),
        .S(S_wire)
    );

    // Register inputs and outputs on clock edge
    always @(posedge clk) begin
        A_reg <= A_in;
        B_reg <= B_in;
        Cin_reg <= Cin_in;

        S_out <= S_wire;
        Cout_out <= Cout_wire;
    end

endmodule

// 16-bit Carry Bypass Adder composed of 4 x 4-bit adders
module carrybypass( 
    input [15:0] A, 
    input [15:0] B, 
    input Cin, 
    output Cout, 
    output [15:0] S);

    wire [3:0] c;

    cbp4bit cbp0(.A(A[3:0]),     .B(B[3:0]),     .Cin(Cin),   .Cout(c[0]), .S(S[3:0]));
    cbp4bit cbp1(.A(A[7:4]),     .B(B[7:4]),     .Cin(c[0]),  .Cout(c[1]), .S(S[7:4]));
    cbp4bit cbp2(.A(A[11:8]),    .B(B[11:8]),    .Cin(c[1]),  .Cout(c[2]), .S(S[11:8]));
    cbp4bit cbp3(.A(A[15:12]),   .B(B[15:12]),   .Cin(c[2]),  .Cout(c[3]), .S(S[15:12]));

    assign Cout = c[3];
endmodule

// 4-bit Carry Bypass Block
module cbp4bit( 
    input [3:0] A, B,
    input Cin,
    output Cout,
    output [3:0] S);

    wire [4:0] C;
    wire q, r;

    assign C[0] = Cin;

    fulladdr fa0(.a(A[0]), .b(B[0]), .cin(C[0]), .cout(C[1]), .Sum(S[0]));
    fulladdr fa1(.a(A[1]), .b(B[1]), .cin(C[1]), .cout(C[2]), .Sum(S[1]));
    fulladdr fa2(.a(A[2]), .b(B[2]), .cin(C[2]), .cout(C[3]), .Sum(S[2]));
    fulladdr fa3(.a(A[3]), .b(B[3]), .cin(C[3]), .cout(C[4]), .Sum(S[3]));

    bypass by0(.A(A), .B(B), .p(q));
    mux21 mu0(.i0(C[4]), .i1(C[0]), .sel(q), .o(r));

    assign Cout = r;
endmodule

// 2:1 Multiplexer
module mux21( 
    input i0, 
    input i1, 
    input sel, 
    output o);
    assign o = sel ? i1 : i0;
endmodule

// Bypass condition generator: produces propagate signal
module bypass( 
    input [3:0] A, 
    input [3:0] B, 
    output p);
    wire [3:0] P;
    assign P = A ^ B;
    assign p = P[0] & P[1] & P[2] & P[3];
endmodule

// 1-bit Full Adder
module fulladdr( 
    input a, 
    input b, 
    input cin, 
    output cout, 
    output Sum);
    assign cout = (a & b) | (a & cin) | (b & cin);
    assign Sum = a ^ b ^ cin;
endmodule

