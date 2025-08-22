// sch_path: /home/ee22b074/ee5311/tutorial_7/partb/bittb.sch
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
 .Cout( Cout ),
 .cin( Cin )
);

endmodule

// expanding   symbol:  test.sym # of pins=5
// sym_path: /home/ee22b074/ee5311/tutorial_7/partb/test.sym
// sch_path: /home/ee22b074/ee5311/tutorial_7/partb/test.sch
module test
(
  input wire [15:0] a,
  output wire [15:0] sum,
  input wire [15:0] b,
  output wire Cout,
  input wire cin
);
wire [14:0] carry;

fulladder fa0(.A(a[0]), .B(b[0]), .Cin(cin), .S(sum[0]), .Cout(carry[0]));
fulladder fa1(.A(a[1]), .B(b[1]), .Cin(carry[0]), .S(sum[1]), .Cout(carry[1]));
fulladder fa2(.A(a[2]), .B(b[2]), .Cin(carry[1]), .S(sum[2]), .Cout(carry[2]));
fulladder fa3(.A(a[3]), .B(b[3]), .Cin(carry[2]), .S(sum[3]), .Cout(carry[3]));
fulladder fa4(.A(a[4]), .B(b[4]), .Cin(carry[3]), .S(sum[4]), .Cout(carry[4]));
fulladder fa5(.A(a[5]), .B(b[5]), .Cin(carry[4]), .S(sum[5]), .Cout(carry[5]));
fulladder fa6(.A(a[6]), .B(b[6]), .Cin(carry[5]), .S(sum[6]), .Cout(carry[6]));
fulladder fa7(.A(a[7]), .B(b[7]), .Cin(carry[6]), .S(sum[7]), .Cout(carry[7]));
fulladder fa8(.A(a[8]), .B(b[8]), .Cin(carry[7]), .S(sum[8]), .Cout(carry[8]));
fulladder fa9(.A(a[9]), .B(b[9]), .Cin(carry[8]), .S(sum[9]), .Cout(carry[9]));
fulladder fa10(.A(a[10]), .B(b[10]), .Cin(carry[9]), .S(sum[10]), .Cout(carry[10]));
fulladder fa11(.A(a[11]), .B(b[11]), .Cin(carry[10]), .S(sum[11]), .Cout(carry[11]));
fulladder fa12(.A(a[12]), .B(b[12]), .Cin(carry[11]), .S(sum[12]), .Cout(carry[12]));
fulladder fa13(.A(a[13]), .B(b[13]), .Cin(carry[12]), .S(sum[13]), .Cout(carry[13]));
fulladder fa14(.A(a[14]), .B(b[14]), .Cin(carry[13]), .S(sum[14]), .Cout(carry[14]));
fulladder fa15(.A(a[15]), .B(b[15]), .Cin(carry[14]), .S(sum[15]), .Cout(Cout));

endmodule
module fulladder
(
  input wire A,
  output wire S,
  input wire B,
  output wire Cout,
  input wire Cin
);
assign S = A ^ B ^ Cin;
assign Cout = (A & B) | (B & Cin) | (Cin & A);
// noconn a[15:0]
// noconn b[15:0]
// noconn cin
// noconn sum[15:0]
// noconn Cout
endmodule
