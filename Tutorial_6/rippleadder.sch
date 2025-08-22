v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -200 -50 -50 -50 {lab=#net1}
N -540 -120 -320 -120 {lab=A1}
N -400 -220 -400 -120 {lab=A1}
N -400 -220 -50 -220 {lab=A1}
N -50 -220 -50 -120 {lab=A1}
N -50 -120 -50 -80 {lab=A1}
N -100 -120 -70 -120 {lab=sum1}
N -200 -120 -180 -120 {lab=#net2}
N -70 -190 -70 -120 {lab=sum1}
N -70 -190 -0 -190 {lab=sum1}
N -540 -120 -540 -50 {lab=A1}
N -430 -80 -320 -80 {lab=B1}
N -430 -80 -430 100 {lab=B1}
N -580 100 -430 100 {lab=B1}
N -330 110 -270 110 {lab=Vin1}
N -330 -50 -330 110 {lab=Vin1}
N -330 -50 -320 -50 {lab=Vin1}
C {fulladder.sym} -260 -80 0 0 {name=x1}
C {fulladder.sym} 10 -80 0 0 {name=x2}
C {inverter.sym} -230 -120 0 0 {name=x3}
C {vsource.sym} -680 -30 0 0 {name=Vdd1 value=1.8 savecurrent=false}
C {gnd.sym} -680 0 0 0 {name=l1 lab=GND}
C {vdd.sym} -680 -60 0 0 {name=l2 lab=VDD}
C {vsource.sym} -540 -20 0 0 {name=Vin1 value="0 PULSE(0 1.8 0ns 10ps 10ps 2ns 4ns)" savecurrent=false}
C {gnd.sym} -540 10 0 0 {name=l3 lab=GND}
C {code_shown.sym} -60 70 0 0 {name=s1 only_toplevel=false value="
.control

tran 10ps 10ns  
* Run transient simulation

meas tran tplh TRIG V(Vin1) VAL=0.9 RISE=1 TARG V(C01) VAL=0.9 FALL=1
meas tran tpdhl TRIG V(Vin1) VAL=0.9 FALL=1 TARG V(C01) VAL=0.9 RISE=1
let tpd_Cout = ($&tplh + $&tpdhl)/2
meas tran tpd_Sumh TRIG V(Vin1) VAL=0.9 RISE=1 TARG V(sum1) VAL=0.9 RISE=1
meas tran tpd_Suml TRIG V(Vin1) VAL=0.9 FALL=1 TARG V(sum1) VAL=0.9 FALL=1
let tpd_Sum = ($&tpd_Sumh + $&tpd_Suml)/2

plot C01 sum1
plot Vin1 
plot A1 
plot B1
* Print delay values
echo Delay from Cin to Cout: $&tpd_Cout
echo Delay from Cin to Sum: $&tpd_Sum

.endc
"}
C {sky130_fd_pr/corner.sym} 200 -140 0 0 {name=CORNER only_toplevel=false corner=tt}
C {lab_pin.sym} -140 30 0 0 {name=p1 sig_type=std_logic lab=C01}
C {inverter.sym} -50 -190 0 0 {name=x4}
C {lab_pin.sym} -70 -180 0 0 {name=p3 sig_type=std_logic lab=sum1
}
C {lab_pin.sym} -330 50 0 0 {name=p2 sig_type=std_logic lab=Vin1}
C {vsource.sym} -580 130 0 0 {name=Vin2 value="0 PULSE(0 1.8 0ns 10ps 10ps 4ns 8ns)" savecurrent=false}
C {gnd.sym} -580 160 0 0 {name=l4 lab=GND}
C {vsource.sym} -270 140 0 0 {name=Vin3 value="0 PULSE(0 1.8 0ns 10ps 10ps 1ns 2ns)" savecurrent=false}
C {gnd.sym} -270 170 0 0 {name=l5 lab=GND}
C {lab_pin.sym} -430 70 0 0 {name=p4 sig_type=std_logic lab=B1}
C {lab_pin.sym} -540 -90 0 0 {name=p5 sig_type=std_logic lab=A1}
C {inverter.sym} -140 -100 1 0 {name=x5}
C {inverter.sym} -140 -20 1 0 {name=x6}
