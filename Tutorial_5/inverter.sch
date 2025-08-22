v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 360 280 360 340 {lab=out}
N 280 250 320 250 {lab=in}
N 280 250 280 370 {lab=in}
N 280 370 320 370 {lab=in}
C {ipin.sym} 280 310 0 0 {name=p1 lab=in}
C {gnd.sym} 360 400 0 0 {name=l1 lab=GND}
C {opin.sym} 360 310 0 0 {name=p2 lab=out}
C {vdd.sym} 360 220 0 0 {name=l2 lab=VDD}
C {sky130_fd_pr/nfet3_01v8.sym} 340 370 0 0 {name=M3
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
C {sky130_fd_pr/pfet3_01v8.sym} 340 250 0 0 {name=M1
W=0.84
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
