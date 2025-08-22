// -----------------------------------------------------------------------------
// 16-bit Pipelined Kogge-Stone Adder
// -----------------------------------------------------------------------------
module kogge #(parameter WIDTH = 16)(
  input  wire                 clk,
  input  wire                 rst,
  input  wire [WIDTH-1:0]     a,
  input  wire [WIDTH-1:0]     b,
  input  wire                 cin,
  output reg  [WIDTH-1:0]     sum,
  output reg                  cout
);

  // Stage 0: Generate P and G (initial)
  wire [WIDTH-1:0] P0, G0;
  assign P0 = a ^ b;
  assign G0 = a & b;

  reg [WIDTH-1:0] P0_r, G0_r;
  reg             cin_r;
  always @(posedge clk) begin
    if (rst) begin
      P0_r <= 0; G0_r <= 0; cin_r <= 0;
    end else begin
      P0_r <= P0; G0_r <= G0; cin_r <= cin;
    end
  end

  // Stage 1: level 1 prefix (distance 1)
  wire [WIDTH-1:0] G1, P1;
  genvar i;
  generate
    for (i = 0; i < WIDTH; i = i + 1) begin: LEVEL1
      if (i == 0) begin
        assign G1[i] = G0_r[i];
        assign P1[i] = P0_r[i];
      end else begin
        assign G1[i] = G0_r[i] | (P0_r[i] & G0_r[i-1]);
        assign P1[i] = P0_r[i] & P0_r[i-1];
      end
    end
  endgenerate

  reg [WIDTH-1:0] G1_r, P1_r;
  always @(posedge clk) begin
    if (rst) {G1_r, P1_r} <= 0;
    else     {G1_r, P1_r} <= {G1, P1};
  end

  // Stage 2: level 2 prefix (distance 2)
  wire [WIDTH-1:0] G2, P2;
  generate
    for (i = 0; i < WIDTH; i = i + 1) begin: LEVEL2
      if (i < 2) begin
        assign G2[i] = G1_r[i];
        assign P2[i] = P1_r[i];
      end else begin
        assign G2[i] = G1_r[i] | (P1_r[i] & G1_r[i-2]);
        assign P2[i] = P1_r[i] & P1_r[i-2];
      end
    end
  endgenerate

  reg [WIDTH-1:0] G2_r, P2_r;
  always @(posedge clk) begin
    if (rst) {G2_r, P2_r} <= 0;
    else     {G2_r, P2_r} <= {G2, P2};
  end

  // Stage 3: level 3 prefix (distance 4)
  wire [WIDTH-1:0] G3, P3;
  generate
    for (i = 0; i < WIDTH; i = i + 1) begin: LEVEL3
      if (i < 4) begin
        assign G3[i] = G2_r[i];
        assign P3[i] = P2_r[i];
      end else begin
        assign G3[i] = G2_r[i] | (P2_r[i] & G2_r[i-4]);
        assign P3[i] = P2_r[i] & P2_r[i-4];
      end
    end
  endgenerate

  reg [WIDTH-1:0] G3_r;
  always @(posedge clk) begin
    if (rst) G3_r <= 0;
    else     G3_r <= G3;
  end

  // Stage 4: Final carry and sum
  wire [WIDTH:0] carry;
  assign carry[0] = cin_r;
  generate
    for (i = 0; i < WIDTH; i = i + 1) begin: CARRY_GEN
      assign carry[i+1] = G3_r[i] | (P0_r[i] & carry[i]);
    end
  endgenerate

  always @(posedge clk) begin
    if (rst) begin
      sum <= 0;
      cout <= 0;
    end else begin
      sum <= P0_r ^ carry[WIDTH-1:0];
      cout <= carry[WIDTH];
    end
  end

endmodule

