// sch_path: /home/ee22b074/ee5311/tutorial_7/brentkung/bittb.sch
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
 .sum( Sum ),
 .b( B ),
 .cout( Cout ),
 .cin( Cin )
);

endmodule

// expanding   symbol:  test.sym # of pins=5
// sym_path: /home/ee22b074/ee5311/tutorial_7/brentkung/test.sym
// sch_path: /home/ee22b074/ee5311/tutorial_7/brentkung/test.sch
module test
(
  input wire [15:0] a,
  output wire [15:0] sum,
  input wire [15:0] b,
  output wire cout,
  input wire cin
);
wire [15:0] P, G;
    
    // Generate initial P and G for each bit
    genvar i;
    generate
        for (i = 0; i < 16; i = i + 1) begin : pg_gen
            assign P[i] = a[i] ^ b[i];  // Propagate
            assign G[i] = a[i] & b[i];  // Generate
        end
    endgenerate
    
    // Stage 2: Brent-Kung prefix tree
    wire [15:0] P_level1, G_level1;
    assign P_level1 = P;
    assign G_level1 = G;
    
    // Level 2: Group of 2 bits
    wire [7:0] P_level2, G_level2;
    generate
        for (i = 0; i < 8; i = i + 1) begin : level2
            pg_dot dot2(
                .P1(P_level1[2*i]),
                .G1(G_level1[2*i]),
                .P2(P_level1[2*i+1]),
                .G2(G_level1[2*i+1]),
                .Pout(P_level2[i]),
                .Gout(G_level2[i])
            );
        end
    endgenerate
    
    // Level 3: Group of 4 bits
    wire [3:0] P_level3, G_level3;
    generate
        for (i = 0; i < 4; i = i + 1) begin : level3
            pg_dot dot3(
                .P1(P_level2[2*i]),
                .G1(G_level2[2*i]),
                .P2(P_level2[2*i+1]),
                .G2(G_level2[2*i+1]),
                .Pout(P_level3[i]),
                .Gout(G_level3[i])
            );
        end
    endgenerate
    
    // Level 4: Group of 8 bits
    wire [1:0] P_level4, G_level4;
    generate
        for (i = 0; i < 2; i = i + 1) begin : level4
            pg_dot dot4(
                .P1(P_level3[2*i]),
                .G1(G_level3[2*i]),
                .P2(P_level3[2*i+1]),
                .G2(G_level3[2*i+1]),
                .Pout(P_level4[i]),
                .Gout(G_level4[i])
            );
        end
    endgenerate
    
    // Level 5: Final carry computation (16 bits)
    wire P_level5, G_level5;
    pg_dot dot5(
        .P1(P_level4[0]),
        .G1(G_level4[0]),
        .P2(P_level4[1]),
        .G2(G_level4[1]),
        .Pout(P_level5),
        .Gout(G_level5)
    );
    
    // Carry computation
    wire [16:0] carry;
    assign carry[0] = cin;
    
    // Backward propagation of carries
    assign carry[8] = G_level4[0] | (P_level4[0] & carry[0]);
    assign carry[4] = G_level3[0] | (P_level3[0] & carry[0]);
    assign carry[12] = G_level3[2] | (P_level3[2] & carry[8]);
    assign carry[2] = G_level2[0] | (P_level2[0] & carry[0]);
    assign carry[6] = G_level2[2] | (P_level2[2] & carry[4]);
    assign carry[10] = G_level2[4] | (P_level2[4] & carry[8]);
    assign carry[14] = G_level2[6] | (P_level2[6] & carry[12]);
    
    // Generate remaining carries
    generate
        for (i = 1; i < 16; i = i + 1) begin : carry_gen
            if (i % 2 == 1) begin
                assign carry[i] = G_level1[i-1] | (P_level1[i-1] & carry[i-1]);
            end
            else if (i % 4 == 2) begin
                assign carry[i] = G_level2[i/2-1] | (P_level2[i/2-1] & carry[(i/4)*4]);
            end
            else if (i % 8 == 4) begin
                assign carry[i] = G_level3[i/4-1] | (P_level3[i/4-1] & carry[(i/8)*8]);
            end
        end
    endgenerate
    
    // Final carry out
    assign cout = G_level5 | (P_level5 & carry[0]);
    
    // Stage 3: Sum computation
    generate
        for (i = 0; i < 16; i = i + 1) begin : sum_gen
            assign sum[i] = P[i] ^ carry[i];
        end
    endgenerate
endmodule
module pg_dot(
    input P1,
    input G1,
    input P2,
    input G2,
    output Pout,
    output Gout
);
    assign Gout = G2 | (P2 & G1);
    assign Pout = P2 & P1;

// noconn a[15:0]
// noconn b[15:0]
// noconn cin
// noconn sum[15:0]
// noconn cout
endmodule
