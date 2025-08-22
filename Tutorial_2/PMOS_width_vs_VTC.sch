v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 380 380 440 380 {lab=Vin}
N 440 300 440 380 {lab=Vin}
N 440 300 490 300 {lab=Vin}
N 440 380 440 420 {lab=Vin}
N 440 420 490 420 {lab=Vin}
N 530 330 530 390 {lab=Vout}
N 530 360 590 360 {lab=Vout}
C {sky130_fd_pr/nfet3_01v8.sym} 510 420 0 0 {name=M1
W=0.42
L=0.15
body=GND
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8.sym} 510 300 0 0 {name=M2
W=\{Width\}
L=0.15
body=VDD
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {code_shown.sym} 790 330 0 0 {name=s1 only_toplevel=false value=
"
.param Width = 120

.control
foreach wp 120 12 1.2
	alterparam Width = $wp
	reset
	dc Vin1 0 1.8 0.01
	plot v(Vout) v(Vin)
end
.endc

"}
C {sky130_fd_pr/corner.sym} 870 70 0 0 {name=CORNER only_toplevel=false corner=tt}
C {vsource.sym} 680 310 0 0 {name=Vdd1 value=1.8 savecurrent=false}
C {vsource.sym} 380 410 0 0 {name=Vin1 value=1.8 savecurrent=false}
C {gnd.sym} 380 440 0 0 {name=l1 lab=GND}
C {gnd.sym} 530 450 0 0 {name=l2 lab=GND}
C {gnd.sym} 680 340 0 0 {name=l3 lab=GND}
C {vdd.sym} 680 280 0 0 {name=l4 lab=VDD}
C {vdd.sym} 530 270 0 0 {name=l5 lab=VDD}
C {lab_pin.sym} 380 380 0 0 {name=p1 sig_type=std_logic lab=Vin}
C {lab_pin.sym} 590 360 2 0 {name=p2 sig_type=std_logic lab=Vout}