// sch_path: /home/ee22b074/ee5311/tutorial_7/riptb.sch
module riptb
(

);
wire Sum ;
wire Cout ;
reg A ;
reg B ;
reg Cin ;

initial begin
 	$dumpfile("dumpfile.vcd");
	$dumpvars(0,A,B,Cin,Sum,Cout);
	A=0;
	B=0;
	Cin=0;
end

integer x;
always begin
for (x=1;x<=7;x=x+1)begin
	#10
	A=x[2];
	B=x[1];
	Cin=x[0];
	end
#10
$finish;
end


fulladder
x1 ( 
 .A( A ),
 .S( Sum ),
 .B( B ),
 .Cout( Cout ),
 .Cin( Cin )
);

// noconn A
// noconn B
// noconn Cin
// noconn Sum
// noconn Cout
endmodule

// expanding   symbol:  fulladder.sym # of pins=5
// sym_path: /home/ee22b074/ee5311/tutorial_7/fulladder.sym
// sch_path: /home/ee22b074/ee5311/tutorial_7/fulladder.sch
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
// noconn A
// noconn B
// noconn Cin
// noconn S
// noconn Cout
endmodule
