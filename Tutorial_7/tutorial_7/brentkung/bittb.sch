v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -830 -570 -800 -570 {lab=A[15:0]}
N -830 -550 -800 -550 {lab=B[15:0]}
N -830 -530 -800 -530 {lab=Cin}
N -500 -570 -470 -570 {lab=Sum[15:0]}
N -500 -550 -470 -550 {lab=Cout}
C {verilog_code.sym} -1280 -690 0 0 {name=s1 string="
initial begin
    $dumpfile(\\"dumpfile1.vcd\\");
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
  end"}
C {noconn.sym} -820 -570 1 0 {name=l1}
C {noconn.sym} -820 -550 1 0 {name=l2}
C {noconn.sym} -820 -530 1 0 {name=l3}
C {lab_wire.sym} -830 -530 0 0 {name=p3 verilog_type=reg lab=Cin}
C {lab_wire.sym} -830 -550 0 0 {name=p1 verilog_type=reg lab=B[15:0]}
C {lab_wire.sym} -830 -570 0 0 {name=p2 verilog_type=reg lab=A[15:0]}
C {noconn.sym} -480 -570 1 0 {name=l4}
C {noconn.sym} -490 -550 3 0 {name=l5}
C {lab_wire.sym} -470 -570 2 0 {name=p4 sig_type=std_logic lab=Sum[15:0]}
C {lab_wire.sym} -470 -550 2 0 {name=p5 sig_type=std_logic lab=Cout}
C {test.sym} -650 -550 0 0 {name=x1}
