// sch_path: /home/ee22b074/ee5311/tutorial_7/brent/bittb.sch
module bittb
(

);
wire [15:0] Sum ;
reg [15:0] A ;
wire Cout ;
reg [15:0] B ;
reg Cin ;

initial begin
    $dumpfile("dumpfile1.vcd");
    $dumpvars(0, A[15:0], B[15:0], Cin, Sum[15:0], Cout);
    A = 0;
    B = 0;
    Cin = 0;
  end

  integer i;
  always begin
    for (i = 0; i < 20; i = i + 1) begin
      #10
      A = $random;
      B = $random;
      Cin = $random % 2;
    end
    #10
    $finish;
  end
// noconn A[15:0]
// noconn B[15:0]
// noconn Cin
// noconn Sum[15:0]
// noconn Cout
test
x1 ( 
 .a( A ),
 .S( Sum ),
 .b( B ),
 .cout( Cout ),
 .sel( Cin )
);

endmodule

// expanding   symbol:  test.sym # of pins=5
// sym_path: /home/ee22b074/ee5311/tutorial_7/brent/test.sym
// sch_path: /home/ee22b074/ee5311/tutorial_7/brent/test.sch
module test
(
  input wire [15:0] a,
  output wire [15:0] S,
  input wire [15:0] b,
  output wire cout,
  input wire sel
);
wire [15:0] b_res;
    wire cin = sel;

    assign b_res = b ^ {16{sel}}; // If sel=1, take 2's complement of b

    // Propagate and Generate signals
    wire [15:0] p, g;
    assign p = a ^ b_res;
    assign g = a & b_res;

    // Group generate signals for each level
    wire [3:0] lvl1_G;
    wire [1:0] lvl2_G;
    wire [0:0] lvl3_G;
    wire [7:0] lvl4_G;

    // Level 1 (per 2 bits)
    assign lvl1_G[0] = g[0] | (p[0] & cin);
    assign lvl1_G[1] = g[1] | (p[1] & lvl1_G[0]);
    assign lvl1_G[2] = g[2] | (p[2] & lvl1_G[1]);
    assign lvl1_G[3] = g[3] | (p[3] & lvl1_G[2]);

    // Level 2 (per 4 bits)
    assign lvl2_G[0] = g[4] | (p[4] & lvl1_G[3]);
    assign lvl2_G[1] = g[5] | (p[5] & lvl2_G[0]);

    // Level 3 (per 8 bits)
    assign lvl3_G[0] = g[6] | (p[6] & lvl2_G[1]);

    // Level 4 (complete 16 bits)
    assign lvl4_G[0] = g[7]  | (p[7]  & lvl3_G[0]);
    assign lvl4_G[1] = g[8]  | (p[8]  & lvl4_G[0]);
    assign lvl4_G[2] = g[9]  | (p[9]  & lvl4_G[1]);
    assign lvl4_G[3] = g[10] | (p[10] & lvl4_G[2]);
    assign lvl4_G[4] = g[11] | (p[11] & lvl4_G[3]);
    assign lvl4_G[5] = g[12] | (p[12] & lvl4_G[4]);
    assign lvl4_G[6] = g[13] | (p[13] & lvl4_G[5]);
    assign lvl4_G[7] = g[14] | (p[14] & lvl4_G[6]);

    // Final sum bits using 'circle' (1-bit adder)
    circle circle_0  (a[0],  b_res[0],  cin,         S[0]);
    circle circle_1  (a[1],  b_res[1],  lvl1_G[0],   S[1]);
    circle circle_2  (a[2],  b_res[2],  lvl1_G[1],   S[2]);
    circle circle_3  (a[3],  b_res[3],  lvl1_G[2],   S[3]);
    circle circle_4  (a[4],  b_res[4],  lvl1_G[3],   S[4]);
    circle circle_5  (a[5],  b_res[5],  lvl2_G[0],   S[5]);
    circle circle_6  (a[6],  b_res[6],  lvl2_G[1],   S[6]);
    circle circle_7  (a[7],  b_res[7],  lvl3_G[0],   S[7]);
    circle circle_8  (a[8],  b_res[8],  lvl4_G[0],   S[8]);
    circle circle_9  (a[9],  b_res[9],  lvl4_G[1],   S[9]);
    circle circle_10 (a[10], b_res[10], lvl4_G[2],   S[10]);
    circle circle_11 (a[11], b_res[11], lvl4_G[3],   S[11]);
    circle circle_12 (a[12], b_res[12], lvl4_G[4],   S[12]);
    circle circle_13 (a[13], b_res[13], lvl4_G[5],   S[13]);
    circle circle_14 (a[14], b_res[14], lvl4_G[6],   S[14]);
    circle circle_15 (a[15], b_res[15], lvl4_G[7],   S[15]);

    assign cout = g[15] | (p[15] & lvl4_G[7]);

endmodule

// noconn a[15:0]
// noconn b[15:0]
// noconn sel
// noconn S[15:0]
// noconn cout
module circle(input a, input b, input cin, output s);
    assign s = a ^ b ^ cin;

endmodule
