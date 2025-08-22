v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
C {verilog_code.sym} -200 -660 0 0 {name=s1 string="
    wire [15:0] G_Z, P_Z;
    wire [15:0] G_A, P_A;
    wire [15:0] G_B, P_B;
    wire [15:0] G_C, P_C;
    wire [15:0] G_D, P_D;
    wire [15:0] G_E, P_E;

    // Level 0 - Generate P_Z and G_Z
    genvar i;
    generate
        for (i = 0; i < 16; i = i + 1) begin : gen_pg
            and_xor level_Z(x[i], y[i], P_Z[i], G_Z[i]);
        end
    endgenerate

    // Level 1
    gray_cell level_0A(cin, P_Z[0], G_Z[0], G_A[0]);
    generate
        for (i = 1; i < 16; i = i + 1) begin : level_A
            black_cell bc(G_Z[i-1], P_Z[i], G_Z[i], P_Z[i-1], G_A[i], P_A[i]);
        end
    endgenerate

    // Level 2
    gray_cell level_1B(cin, P_A[1], G_A[1], G_B[1]);
    gray_cell level_2B(G_A[0], P_A[2], G_A[2], G_B[2]);
    generate
        for (i = 3; i < 16; i = i + 1) begin : level_B
            black_cell bc(G_A[i-2], P_A[i], G_A[i], P_A[i-2], G_B[i], P_B[i]);
        end
    endgenerate

    // Level 3
    gray_cell level_3C(cin, P_B[3], G_B[3], G_C[3]);
    gray_cell level_4C(G_A[0], P_B[4], G_B[4], G_C[4]);
    gray_cell level_5C(G_B[1], P_B[5], G_B[5], G_C[5]);
    gray_cell level_6C(G_B[2], P_B[6], G_B[6], G_C[6]);
    generate
        for (i = 7; i < 16; i = i + 1) begin : level_C
            black_cell bc(G_B[i-4], P_B[i], G_B[i], P_B[i-4], G_C[i], P_C[i]);
        end
    endgenerate

    // Level 4
    gray_cell level_7D(cin, P_C[7], G_C[7], G_D[7]);
    gray_cell level_8D(G_A[0], P_C[8], G_C[8], G_D[8]);
    gray_cell level_9D(G_B[1], P_C[9], G_C[9], G_D[9]);
    gray_cell level_10D(G_B[2], P_C[10], G_C[10], G_D[10]);
    gray_cell level_11D(G_C[3], P_C[11], G_C[11], G_D[11]);
    generate
        for (i = 12; i < 16; i = i + 1) begin : level_D
            black_cell bc(G_C[i-8], P_C[i], G_C[i], P_C[i-8], G_D[i], P_D[i]);
        end
    endgenerate

    // Level 5 (final carry to cout)
    gray_cell level_15E(cin, P_D[15], G_D[15], cout);

    // Final sum computation
    assign sum[0] = cin ^ P_Z[0];
    assign sum[1] = G_A[0] ^ P_Z[1];
    assign sum[2] = G_B[1] ^ P_Z[2];
    assign sum[3] = G_B[2] ^ P_Z[3];
    assign sum[4] = G_C[3] ^ P_Z[4];
    assign sum[5] = G_C[4] ^ P_Z[5];
    assign sum[6] = G_C[5] ^ P_Z[6];
    assign sum[7] = G_C[6] ^ P_Z[7];
    assign sum[8] = G_D[7] ^ P_Z[8];
    assign sum[9] = G_D[8] ^ P_Z[9];
    assign sum[10] = G_D[9] ^ P_Z[10];
    assign sum[11] = G_D[10] ^ P_Z[11];
    assign sum[12] = G_D[11] ^ P_Z[12];
    assign sum[13] = G_D[12] ^ P_Z[13];
    assign sum[14] = G_D[13] ^ P_Z[14];
    assign sum[15] = G_D[14] ^ P_Z[15];

endmodule

"}
C {ipin.sym} -570 -70 0 0 {name=p1 lab=x[15:0]}
C {noconn.sym} -570 -70 1 0 {name=l1}
C {ipin.sym} -570 -50 0 0 {name=p2 lab=y[15:0]}
C {noconn.sym} -570 -50 1 0 {name=l2}
C {ipin.sym} -570 -30 0 0 {name=p3 lab=cin}
C {noconn.sym} -570 -30 1 0 {name=l3}
C {opin.sym} -420 -70 0 0 {name=p4 lab=sum[15:0]}
C {noconn.sym} -420 -70 1 0 {name=l4}
C {opin.sym} -420 -40 0 0 {name=p5 lab=cout}
C {noconn.sym} -420 -40 1 0 {name=l5}
C {verilog_code.sym} -1070 -280 0 0 {name=s2 string="
module black_cell(Gkj, Pik, Gik, Pkj, G, P);
 input Gkj, Pik, Gik, Pkj;
 output G, P;
 wire Y;

 and(Y, Gkj, Pik);
 or(G, Gik, Y);
 and(P, Pkj, Pik);
endmodule
"}
C {verilog_code.sym} -1080 50 0 0 {name=s3 string="
module and_xor(a, b, p, g);
 //very first inputs - and/xor
 input a, b;
 output p, g;
 xor(p, a, b);
 and(g, a, b);
 endmodule
"}
C {verilog_code.sym} -1080 310 0 0 {name=s4 string="
module gray_cell(Gkj, Pik, Gik, G);
 //gray cell
 input Gkj, Pik, Gik;
 output G;
 wire Y;
 and(Y, Gkj, Pik);
 or(G, Y, Gik);
"}
