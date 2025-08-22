v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
C {verilog_code.sym} -640 -240 0 0 {name=s1 string="assign S = A ^ B ^ Cin;
assign Cout = (A & B) | (B & Cin) | (Cin & A);"}
C {ipin.sym} -670 -250 0 0 {name=p1 lab=A}
C {noconn.sym} -670 -250 1 0 {name=l1}
C {ipin.sym} -670 -220 0 0 {name=p2 lab=B}
C {noconn.sym} -670 -220 1 0 {name=l2}
C {ipin.sym} -670 -190 0 0 {name=p3 lab=Cin}
C {noconn.sym} -670 -190 1 0 {name=l3}
C {opin.sym} -270 -250 0 0 {name=p4 lab=S}
C {noconn.sym} -270 -250 1 0 {name=l4}
C {opin.sym} -270 -210 0 0 {name=p5 lab=Cout}
C {noconn.sym} -270 -210 1 0 {name=l5}
