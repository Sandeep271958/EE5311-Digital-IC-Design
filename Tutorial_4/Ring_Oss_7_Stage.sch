v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 60 110 110 110 {lab=Vout}
N 60 110 60 260 {lab=Vout}
N 60 260 1510 260 {lab=Vout}
N 1510 110 1510 260 {lab=Vout}
N 1450 110 1510 110 {lab=Vout}
N 1240 110 1330 110 {lab=#net1}
N 1040 110 1120 110 {lab=#net2}
N 850 110 920 110 {lab=#net3}
N 640 110 730 110 {lab=#net4}
N 440 110 520 110 {lab=#net5}
N 230 110 320 110 {lab=#net6}

C {inverter.sym} 70 110 0 0 {name=x1}
C {inverter.sym} 280 110 0 0 {name=x2}
C {inverter.sym} 480 110 0 0 {name=x3}
C {inverter.sym} 690 110 0 0 {name=x4}
C {inverter.sym} 880 110 0 0 {name=x5}
C {inverter.sym} 1080 110 0 0 {name=x6}
C {inverter.sym} 1290 110 0 0 {name=x7}

C {lab_wire.sym} 1490 110 1 0 {name=p1 sig_type=std_logic lab=Vout}
C {sky130_fd_pr/corner.sym} 80 480 0 0 {name=CORNER only_toplevel=false corner=tt}

C {code_shown.sym} 310 470 0 0 {name=sim only_toplevel=false value="
.param width_p = 0.84 
.param VDDval = 1.8 
.ic v(Vout) = 0 
.control 
reset 
set noaskquit 
let Nsim= 9 
let step =0.1 
let index = 0 
let freqvec = vector(Nsim) 
let vddvec = vector(Nsim) 
let timevec = vector(Nsim) 
while index < Nsim  
	let vddv= 1.0+ index*step 
	alterparam VDDval = $&vddv 
	let vby2 = $&vddv / 2 
	reset 
	tran 10ps 50ns 
	meas tran tl FIND time WHEN V(Vout)= $&vby2 RISE=1 
	meas tran t2 FIND time WHEN V(Vout)= $&vby2 RISE=2 
	let period = t2 -tl 
	let frequency= 1/period 
	let timevec[index] =period 
	let freqvec[index] = frequency 
	let vddvec[index] = vddv 
	let index = index+1
end 
print vddvec 
print freqvec 
print timevec 
plot freqvec vs vddvec 
plot timevec vs vddvec 
.endc
"}

C {vsource.sym} 800 500 0 0 {name=Vdd1 value=\{VDDval\} savecurrent=false}
C {gnd.sym} 800 530 0 0 {name=l1 lab=GND}
C {vdd.sym} 800 470 0 0 {name=l2 lab=VDD}
