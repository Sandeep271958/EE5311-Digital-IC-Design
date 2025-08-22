//----------------------------------------------------------------------------- 
// 16-bit Sklansky Adder (Pipelined) 
//-----------------------------------------------------------------------------
module sklansky #(
  parameter WIDTH = 16
)(
  input  wire                 clk,
  input  wire                 rst,    // synchronous reset, active-high
  input  wire [WIDTH-1:0]     a,
  input  wire [WIDTH-1:0]     b,
  input  wire                 cin,
  output reg  [WIDTH-1:0]     sum,
  output reg                  cout
);

  // --------------------------------------------------------------------------
  // Stage 0: Register Inputs
  // --------------------------------------------------------------------------
  reg [WIDTH-1:0] a_r, b_r;
  reg             cin_r;
  always @(posedge clk) begin
    if (rst) begin
      a_r   <= 0;
      b_r   <= 0;
      cin_r <= 0;
    end else begin
      a_r   <= a;
      b_r   <= b;
      cin_r <= cin;
    end
  end

  // --------------------------------------------------------------------------
  // Stage 1: Compute bitwise P/G
  // --------------------------------------------------------------------------
  wire [WIDTH-1:0] P0, G0;
  assign P0 = a_r ^ b_r;
  assign G0 = a_r & b_r;

  // --------------------------------------------------------------------------
  // Sklansky Tree Generation
  // --------------------------------------------------------------------------
  wire [WIDTH-1:0] G1, P1;
  wire [WIDTH-1:0] G2, P2;
  wire [WIDTH-1:0] G3, P3;
  wire [WIDTH-1:0] G4, P4;

  genvar i;
  generate
    for (i = 0; i < WIDTH; i = i + 1) begin : STAGE1
      if (i == 0) begin
        assign G1[i] = G0[i];
        assign P1[i] = P0[i];
      end else if (i % 2 == 1) begin
        pg_dot u1 (.P1(P0[i-1]), .G1(G0[i-1]), .P2(P0[i]), .G2(G0[i]), .Pout(P1[i]), .Gout(G1[i]));
        assign G1[i-1] = G0[i-1];
        assign P1[i-1] = P0[i-1];
      end
    end
  endgenerate

  generate
    for (i = 0; i < WIDTH; i = i + 1) begin : STAGE2
      if (i < 2) begin
        assign G2[i] = G1[i];
        assign P2[i] = P1[i];
      end else if (i % 4 >= 2) begin
        pg_dot u2 (.P1(P1[i-2]), .G1(G1[i-2]), .P2(P1[i]), .G2(G1[i]), .Pout(P2[i]), .Gout(G2[i]));
      end else begin
        assign G2[i] = G1[i];
        assign P2[i] = P1[i];
      end
    end
  endgenerate

  generate
    for (i = 0; i < WIDTH; i = i + 1) begin : STAGE3
      if (i < 4) begin
        assign G3[i] = G2[i];
        assign P3[i] = P2[i];
      end else if (i % 8 >= 4) begin
        pg_dot u3 (.P1(P2[i-4]), .G1(G2[i-4]), .P2(P2[i]), .G2(G2[i]), .Pout(P3[i]), .Gout(G3[i]));
      end else begin
        assign G3[i] = G2[i];
        assign P3[i] = P2[i];
      end
    end
  endgenerate

  generate
    for (i = 0; i < WIDTH; i = i + 1) begin : STAGE4
      if (i < 8) begin
        assign G4[i] = G3[i];
        assign P4[i] = P3[i];
      end else if (i % 16 >= 8) begin
        pg_dot u4 (.P1(P3[i-8]), .G1(G3[i-8]), .P2(P3[i]), .G2(G3[i]), .Pout(P4[i]), .Gout(G4[i]));
      end else begin
        assign G4[i] = G3[i];
        assign P4[i] = P3[i];
      end
    end
  endgenerate

  // --------------------------------------------------------------------------
  // Final Carry Generation and Sum Calculation
  // --------------------------------------------------------------------------
  wire [WIDTH:0] carry;
  assign carry[0] = cin_r;
  
  generate
    for (i = 0; i < WIDTH; i = i + 1) begin : FINAL_CARRY
      assign carry[i+1] = G4[i] | (P4[i] & carry[0]);
    end
  endgenerate

  always @(posedge clk) begin
    if (rst) begin
      sum  <= 0;
      cout <= 0;
    end else begin
      sum  <= P0 ^ carry[WIDTH-1:0];
      cout <= carry[WIDTH];
    end
  end

endmodule


//----------------------------------------------------------------------------- 
// pg_dot: 2-input prefix operator 
//----------------------------------------------------------------------------- 
module pg_dot (
  input  wire P1, G1,
  input  wire P2, G2,
  output wire Pout, Gout
);
  assign Gout = G2 | (P2 & G1);
  assign Pout = P2 & P1;
endmodule

