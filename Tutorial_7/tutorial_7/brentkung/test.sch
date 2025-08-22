v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
C {verilog_code.sym} -140 -280 0 0 {name=s1 string="
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
"}
C {ipin.sym} -570 -70 0 0 {name=p1 lab=a[15:0]}
C {noconn.sym} -570 -70 1 0 {name=l1}
C {ipin.sym} -570 -50 0 0 {name=p2 lab=b[15:0]}
C {noconn.sym} -570 -50 1 0 {name=l2}
C {ipin.sym} -570 -30 0 0 {name=p3 lab=cin}
C {noconn.sym} -570 -30 1 0 {name=l3}
C {opin.sym} -420 -70 0 0 {name=p4 lab=sum[15:0]}
C {noconn.sym} -420 -70 1 0 {name=l4}
C {opin.sym} -420 -40 0 0 {name=p5 lab=cout}
C {noconn.sym} -420 -40 1 0 {name=l5}
