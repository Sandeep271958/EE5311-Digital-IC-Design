v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -270 -390 -240 -390 {lab=A}
N -270 -370 -240 -370 {lab=B}
N -270 -350 -240 -350 {lab=Cin}
N -90 -390 -60 -390 {lab=Sum}
N -90 -360 -60 -360 {lab=Cout}
C {verilog_code.sym} -630 -520 0 0 {name=s1 string="
initial begin
 	$dumpfile(\\"dumpfile.vcd\\");
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

"}
C {fulladder.sym} -90 -370 0 0 {name=x1}
C {noconn.sym} -260 -390 1 0 {name=l1}
C {noconn.sym} -260 -370 1 0 {name=l2}
C {noconn.sym} -260 -350 1 0 {name=l3}
C {noconn.sym} -70 -390 1 0 {name=l4}
C {noconn.sym} -70 -360 1 0 {name=l5}
C {lab_wire.sym} -270 -350 0 0 {name=p3 verilog_type=reg lab=Cin}
C {lab_wire.sym} -270 -370 0 0 {name=p1 verilog_type=reg lab=B}
C {lab_wire.sym} -270 -390 0 0 {name=p2 verilog_type=reg lab=A}
C {lab_wire.sym} -60 -390 2 0 {name=p4 sig_type=std_logic lab=Sum}
C {lab_wire.sym} -60 -360 2 0 {name=p5 sig_type=std_logic lab=Cout}
