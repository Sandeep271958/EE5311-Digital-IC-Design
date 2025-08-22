module brentkung_clk(
    input clk,
    input [15:0] a_in,
    input [15:0] b_in,
    input cin_in,
    output reg [15:0] s_out,
    output reg cout_out);

    reg [15:0] a_reg;
    reg [15:0] b_reg;
    reg cin_reg;

    wire [15:0] s_wire;
    wire cout_wire;

    // Instantiate the actual Brent-Kung adder
    brentkung bk_adder(
        .a(a_reg),
        .b(b_reg),
        .cin(cin_reg),
        .s(s_wire),
        .cout(cout_wire));

    // Register inputs and outputs on clock edge
    always @(posedge clk) begin
        a_reg <= a_in;
        b_reg <= b_in;
        cin_reg <= cin_in;

        s_out <= s_wire;
        cout_out <= cout_wire;
    end
endmodule

// sch_path: /home/ee22b045/ee5311/tutorial_7/brentkung.sch
module brentkung
(
	input wire [15:0] a,
  input wire [15:0] b,
  input wire cin,
  output wire [15:0] S,
  output wire cout
);
wire [16:0] [16:0] g;
wire [16:0] [16:0] p;

assign g[0][0]=cin;
assign p[0][0]=1'b0;
	
	GP GP_00(a[0],b[0],g[1][1],p[1][1]);
	GP GP_01(a[1],b[1],g[2][2],p[2][2]);
	GP GP_02(a[2],b[2],g[3][3],p[3][3]);
	GP GP_03(a[3],b[3],g[4][4],p[4][4]);
	GP GP_04(a[4],b[4],g[5][5],p[5][5]);
	GP GP_05(a[5],b[5],g[6][6],p[6][6]);
	GP GP_06(a[6],b[6],g[7][7],p[7][7]);
	GP GP_07(a[7],b[7],g[8][8],p[8][8]);
	GP GP_08(a[8],b[8],g[9][9],p[9][9]);
	GP GP_09(a[9],b[9],g[10][10],p[10][10]);
	GP GP_10(a[10],b[10],g[11][11],p[11][11]);
	GP GP_11(a[11],b[11],g[12][12],p[12][12]);
	GP GP_12(a[12],b[12],g[13][13],p[13][13]);
	GP GP_13(a[13],b[13],g[14][14],p[14][14]);
	GP GP_14(a[14],b[14],g[15][15],p[15][15]);
	GP GP_15(a[15],b[15],g[16][16],p[16][16]);
	
	//layer_1
	Grey cell_1_1(g[1][1],p[1][1],g[0][0],g[1][0]);
	Black cell_1_3(g[3][3],p[3][3],g[2][2],p[2][2],g[3][2],p[3][2]);
	Black cell_1_5(g[5][5],p[5][5],g[4][4],p[4][4],g[5][4],p[5][4]);
	Black cell_1_7(g[7][7],p[7][7],g[6][6],p[6][6],g[7][6],p[7][6]);
	Black cell_1_9(g[9][9],p[9][9],g[8][8],p[8][8],g[9][8],p[9][8]);
	Black cell_1_11(g[11][11],p[11][11],g[10][10],p[10][10],g[11][10],p[11][10]);
	Black cell_1_13(g[13][13],p[13][13],g[12][12],p[12][12],g[13][12],p[13][12]);
	Black cell_1_15(g[15][15],p[15][15],g[14][14],p[14][14],g[15][14],p[15][14]);
	
	//layer_2
	Grey cell_2_3(g[3][2],p[3][2],g[1][0],g[3][0]);
	Black cell_2_7(g[7][6],p[7][6],g[5][4],p[5][4],g[7][4],p[7][4]);
	Black cell_2_11(g[11][10],p[11][10],g[9][8],p[9][8],g[11][8],p[11][8]);
	Black cell_2_15(g[15][14],p[15][14],g[13][12],p[13][12],g[15][12],p[15][12]);
	
	//layer_3
	Grey cell_3_7(g[7][4],p[7][4],g[3][0],g[7][0]);
	Black cell_3_15(g[15][12],p[15][12],g[11][8],p[11][8],g[15][8],p[15][8]);
	
	//layer_4
	Grey cell_4_15(g[15][8],p[15][8],g[7][0],g[15][0]);
	
	//layer_5
	Grey cell_5_11(g[11][8],p[11][8],g[7][0],g[11][0]);
	
	//layer_6
	Grey cell_6_5(g[5][4],p[5][4],g[3][0],g[5][0]);
	Grey cell_6_9(g[9][8],p[9][8],g[7][0],g[9][0]);
	Grey cell_6_13(g[13][12],p[13][12],g[11][0],g[13][0]);
	
	//layer_7
	Grey cell_7_2(g[2][2],p[2][2],g[1][0],g[2][0]);
	Grey cell_7_4(g[4][4],p[4][4],g[3][0],g[4][0]);
	Grey cell_7_6(g[6][6],p[6][6],g[5][0],g[6][0]);
	Grey cell_7_8(g[8][8],p[8][8],g[7][0],g[8][0]);
	Grey cell_7_10(g[10][10],p[10][10],g[9][0],g[10][0]);
	Grey cell_7_12(g[12][12],p[12][12],g[11][0],g[12][0]);
	Grey cell_7_14(g[14][14],p[14][14],g[13][0],g[14][0]);







  assign S[0]=g[0][0]^p[1][1];
	assign S[1]=g[1][0]^p[2][2];
	assign S[2]=g[2][0]^p[3][3];
	assign S[3]=g[3][0]^p[4][4];
	assign S[4]=g[4][0]^p[5][5];
	assign S[5]=g[5][0]^p[6][6];
	assign S[6]=g[6][0]^p[7][7];
	assign S[7]=g[7][0]^p[8][8];
	assign S[8]=g[8][0]^p[9][9];
	assign S[9]=g[9][0]^p[10][10];
	assign S[10]=g[10][0]^p[11][11];
	assign S[11]=g[11][0]^p[12][12];
	assign S[12]=g[12][0]^p[13][13];
	assign S[13]=g[13][0]^p[14][14];
	assign S[14]=g[14][0]^p[15][15];
	assign S[15]=g[15][0]^p[16][16];
	assign cout=(g[15][0]&p[16][16])|g[16][16];
	
endmodule


	


// noconn cin
// noconn b[15:0]
// noconn a[15:0]
// noconn S[15:0]
// noconn cout
module GP(A,B,G,P);
	input A,B;
	output G,P;
	assign G = A&B;
	assign P = A^B;
endmodule

module Black(G6_8,P6_8,G7_10,P7_10,G6_10,P6_10);
	input G6_8,P6_8,G7_10,P7_10;
	output G6_10,P6_10;
  	wire s1 ;
  	assign s1 = P6_8 & G7_10;
  	assign G6_10=s1 | G6_8;
  	assign P6_10=P6_8 & P7_10;
endmodule

module Grey(G4_3,P4_3,G2_2,G4_2);
  	input G4_3,P4_3,G2_2;
  	output G4_2;
  	wire s1 ;
  	assign s1 = P4_3 & G2_2;
  	assign G4_2=s1 | G4_3;



endmodule
