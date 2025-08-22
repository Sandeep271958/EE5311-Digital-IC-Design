v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -540 -430 -540 -50 {lab=A1}
N -580 100 -430 100 {lab=B1}
N -430 70 -430 100 {lab=B1}
N -430 -250 -430 70 {lab=B1}
N -520 -250 -430 -250 {lab=B1}
N -520 -410 -520 -250 {lab=B1}
N -330 50 -330 100 {lab=Vin1}
N -330 -280 -330 50 {lab=Vin1}
N -490 -280 -330 -280 {lab=Vin1}
N -490 -390 -490 -280 {lab=Vin1}
N 150 -700 210 -700 {lab=S0}
N -330 100 -270 100 {lab=Vin1}
N -270 100 -270 110 {lab=Vin1}
N 150 -540 220 -540 {lab=C7}
N 470 -680 540 -680 {lab=S1}
N 150 -660 210 -660 {lab=S2}
N 470 -640 530 -640 {lab=S3}
N 150 -620 260 -620 {lab=S5}
N 470 -600 540 -600 {lab=S6}
N 150 -580 220 -580 {lab=S4}
N 70 -680 390 -680 {lab=#net1}
N 70 -640 390 -640 {lab=#net2}
N 70 -600 390 -600 {lab=#net3}
N 70 -560 390 -560 {lab=#net4}
N 470 -560 530 -560 {lab=S7}
N -540 -720 -230 -720 {lab=A1}
N -540 -720 -540 -430 {lab=A1}
N -230 -720 -230 -700 {lab=A1}
N -230 -700 -230 -680 {lab=A1}
N -230 -680 -230 -660 {lab=A1}
N -230 -640 -230 -620 {lab=B1}
N -230 -620 -230 -600 {lab=B1}
N -230 -600 -230 -580 {lab=B1}
N -230 -520 -230 -500 {lab=B1}
N -230 -500 -230 -480 {lab=B1}
N -230 -480 -230 -460 {lab=B1}
N -230 -440 -230 -420 {lab=A1}
N -230 -420 -230 -400 {lab=A1}
N -230 -400 -230 -380 {lab=A1}
N -300 -720 -300 -420 {lab=A1}
N -300 -420 -230 -420 {lab=A1}
N -260 -620 -230 -620 {lab=B1}
N -260 -620 -260 -500 {lab=B1}
N -260 -500 -230 -500 {lab=B1}
N -520 -560 -260 -560 {lab=B1}
N -490 -390 -230 -560 {lab=Vin1}
N -520 -560 -520 -410 {lab=B1}
C {inverter.sym} 20 -700 0 0 {name=x3}
C {vsource.sym} -680 -30 0 0 {name=Vdd1 value=1.8 savecurrent=false}
C {gnd.sym} -680 0 0 0 {name=l1 lab=GND}
C {gnd.sym} -540 10 0 0 {name=l3 lab=GND}
C {code_shown.sym} 0 110 0 0 {name=s1 only_toplevel=false value=
"
*.include fulladder_extracted.spice
.control
tran 100ps 100ns
run
meas tran tplh TRIG V(Vin1) VAL=0.9 RISE=1 TARG V(C7) VAL=0.9 FALL=1
meas tran tpdhl TRIG V(Vin1) VAL=0.9 FALL=1 TARG V(C7) VAL=0.9 RISE=1
let tpd_Cout = ($&tplh + $&tpdhl)/2
meas tran tpd_Sumh TRIG V(Vin1) VAL=0.9 RISE=1 TARG V(S7) VAL=0.9 RISE=1
meas tran tpd_Suml TRIG V(Vin1) VAL=0.9 FALL=1 TARG V(S7) VAL=0.9 FALL=1
let tpd_Sum = ($&tpd_Sumh + $&tpd_Suml)/2

plot C7 S0 S1 S2 S3 S4 S5 S6 S7 
plot Vin1 
plot A1 
plot B1

echo Delay from Cin to C7: $&tpd_Cout
echo Delay from Cin to S7: $&tpd_Sum
.endc

"}
C {sky130_fd_pr/corner.sym} 200 -140 0 0 {name=CORNER only_toplevel=false corner=tt}
C {inverter.sym} 160 -700 0 0 {name=x4}
C {lab_pin.sym} -330 50 0 0 {name=p2 sig_type=std_logic lab=Vin1}
C {vsource.sym} -580 130 0 0 {name=Vin2 value="0 PULSE(0 1.8 0ns 10ps 10ps 4ns 8ns)" savecurrent=false}
C {gnd.sym} -580 160 0 0 {name=l4 lab=GND}
C {gnd.sym} -270 170 0 0 {name=l5 lab=GND}
C {lab_pin.sym} -430 70 0 0 {name=p4 sig_type=std_logic lab=B1}
C {lab_pin.sym} -540 -90 0 0 {name=p5 sig_type=std_logic lab=A1}
C {vdd.sym} -680 -60 0 0 {name=l2 lab=VDD}
C {vsource.sym} -540 -20 0 0 {name=Vin1 value="0 PULSE(0 1.8 0ns 10ps 10ps 4ns 8ns)" savecurrent=false}
C {vsource.sym} -270 140 0 0 {name=Vin3 value="0 PULSE(0 1.8 0ns 10ps 10ps 4ns 8ns)" savecurrent=false}
C {inverter.sym} 340 -680 0 0 {name=x20}
C {inverter.sym} 20 -660 0 0 {name=x21}
C {inverter.sym} 170 -540 0 0 {name=x26}
C {inverter.sym} 490 -680 0 0 {name=x27}
C {inverter.sym} 160 -660 0 0 {name=x28}
C {inverter.sym} 480 -640 0 0 {name=x29}
C {inverter.sym} 490 -600 0 0 {name=x30}
C {inverter.sym} 170 -580 0 0 {name=x31}
C {inverter.sym} 480 -560 0 0 {name=x32}
C {inverter.sym} 210 -620 0 0 {name=x34}
C {lab_pin.sym} 190 -700 0 0 {name=p6 sig_type=std_logic lab=S0}
C {lab_pin.sym} 520 -680 3 0 {name=p7 sig_type=std_logic lab=S1}
C {lab_pin.sym} 190 -660 3 0 {name=p8 sig_type=std_logic lab=S2}
C {lab_pin.sym} 510 -640 3 0 {name=p9 sig_type=std_logic lab=S3}
C {lab_pin.sym} 190 -580 1 0 {name=p10 sig_type=std_logic lab=S4}
C {lab_pin.sym} 200 -620 3 0 {name=p11 sig_type=std_logic lab=S5}
C {lab_pin.sym} 490 -600 3 0 {name=p12 sig_type=std_logic lab=S6}
C {lab_pin.sym} 510 -560 0 0 {name=p13 sig_type=std_logic lab=S7}
C {lab_pin.sym} 180 -540 3 0 {name=p14 sig_type=std_logic lab=C7}
C {rippleadder.sym} -80 -550 0 0 {name=x35}
C {inverter.sym} 20 -620 0 0 {name=x36}
C {inverter.sym} 20 -580 0 0 {name=x37}
C {inverter.sym} 20 -540 0 0 {name=x38}
C {inverter.sym} 340 -560 0 0 {name=x40}
C {inverter.sym} 340 -600 0 0 {name=x41}
C {inverter.sym} 340 -640 0 0 {name=x42}
C {gnd.sym} -230 -540 0 0 {name=l6 lab=GND}
C {vdd.sym} 70 -720 0 0 {name=l7 lab=VDD}
