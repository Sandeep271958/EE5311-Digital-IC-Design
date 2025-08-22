//-----------------------------------------------------------------------------
// 16-bit BrentKung Adder (5-stage pipeline  no multi-output gates)
//-----------------------------------------------------------------------------
module brentkung #(
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
  wire [WIDTH-1:0] P1, G1;
  genvar i;
  generate
    for (i = 0; i < WIDTH; i = i + 1) begin : PG1
      assign P1[i] = a_r[i] ^ b_r[i];
      assign G1[i] = a_r[i] & b_r[i];
    end
  endgenerate

  reg [WIDTH-1:0] P1_r, G1_r;
  always @(posedge clk) begin
    if (rst)      {P1_r, G1_r} <= 0;
    else          {P1_r, G1_r} <= {P1,  G1 };
  end

  // --------------------------------------------------------------------------
  // Stage 2: Level-2 prefix (pairs)
  // --------------------------------------------------------------------------
  wire [WIDTH/2-1:0] P2, G2;
  generate
    for (i = 0; i < WIDTH/2; i = i + 1) begin : LVL2
      pg_dot u2(
        .P1  (P1_r[2*i]),   .G1(G1_r[2*i]),
        .P2  (P1_r[2*i+1]), .G2(G1_r[2*i+1]),
        .Pout(P2[i]),       .Gout(G2[i])
      );
    end
  endgenerate

  reg [WIDTH/2-1:0] P2_r, G2_r;
  always @(posedge clk) begin
    if (rst)      {P2_r, G2_r} <= 0;
    else          {P2_r, G2_r} <= {P2,  G2 };
  end

  // --------------------------------------------------------------------------
  // Stage 3: Level-3 prefix (groups of 4)
  // --------------------------------------------------------------------------
  wire [WIDTH/4-1:0] P3, G3;
  generate
    for (i = 0; i < WIDTH/4; i = i + 1) begin : LVL3
      pg_dot u3(
        .P1  (P2_r[2*i]),   .G1(G2_r[2*i]),
        .P2  (P2_r[2*i+1]), .G2(G2_r[2*i+1]),
        .Pout(P3[i]),       .Gout(G3[i])
      );
    end
  endgenerate

  reg [WIDTH/4-1:0] P3_r, G3_r;
  always @(posedge clk) begin
    if (rst)      {P3_r, G3_r} <= 0;
    else          {P3_r, G3_r} <= {P3,  G3 };
  end

  // --------------------------------------------------------------------------
  // Stage 4: Level-4 prefix (groups of 8)
  // --------------------------------------------------------------------------
  wire [WIDTH/8-1:0] P4, G4;
  generate
    for (i = 0; i < WIDTH/8; i = i + 1) begin : LVL4
      pg_dot u4(
        .P1  (P3_r[2*i]),   .G1(G3_r[2*i]),
        .P2  (P3_r[2*i+1]), .G2(G3_r[2*i+1]),
        .Pout(P4[i]),       .Gout(G4[i])
      );
    end
  endgenerate

  reg [WIDTH/8-1:0] P4_r, G4_r;
  always @(posedge clk) begin
    if (rst)      {P4_r, G4_r} <= 0;
    else          {P4_r, G4_r} <= {P4,  G4 };
  end

  // --------------------------------------------------------------------------
  // Stage 5: Level-5 prefix (entire 16)
  // --------------------------------------------------------------------------
  wire P5, G5;
  pg_dot u5(
    .P1  (P4_r[0]), .G1(G4_r[0]),
    .P2  (P4_r[1]), .G2(G4_r[1]),
    .Pout(P5),      .Gout(G5)
  );

  reg P5_r, G5_r;
  always @(posedge clk) begin
    if (rst)      {P5_r, G5_r} <= 0;
    else          {P5_r, G5_r} <= {P5,  G5 };
  end

  // --------------------------------------------------------------------------
  // Stage 6: Compute final carry chain and register sum & cout
  // --------------------------------------------------------------------------
  wire [WIDTH:0] carry;
  assign carry[0]  = cin_r;
  assign carry[1]  = G1_r[0]     | (P1_r[0]     & carry[0]);
  assign carry[2]  = G2_r[0]     | (P2_r[0]     & carry[0]);
  assign carry[3]  = G2_r[1]     | (P2_r[1]     & carry[1]);
  assign carry[4]  = G3_r[0]     | (P3_r[0]     & carry[0]);
  assign carry[5]  = G3_r[1]     | (P3_r[1]     & carry[1]);
  assign carry[6]  = G3_r[2]     | (P3_r[2]     & carry[2]);
  assign carry[7]  = G3_r[3]     | (P3_r[3]     & carry[3]);
  assign carry[8]  = G4_r[0]     | (P4_r[0]     & carry[0]);
  assign carry[9]  = G1_r[8]     | (P1_r[8]     & carry[8]);
  assign carry[10] = G2_r[4]     | (P2_r[4]     & carry[8]);
  assign carry[11] = G1_r[10]    | (P1_r[10]    & carry[10]);
  assign carry[12] = G3_r[2]     | (P3_r[2]     & carry[8]);
  assign carry[13] = G1_r[12]    | (P1_r[12]    & carry[12]);
  assign carry[14] = G2_r[6]     | (P2_r[6]     & carry[12]);
  assign carry[15] = G1_r[14]    | (P1_r[14]    & carry[14]);
  assign carry[16] = G5_r        | (P5_r        & carry[0]);

  always @(posedge clk) begin
    if (rst) begin
      sum  <= 0;
      cout <= 0;
    end else begin
      sum  <= P1_r ^ carry[WIDTH-1:0];
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

