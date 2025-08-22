v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -330 -250 -260 -250 {lab=#net1}
N -260 -250 -260 -230 {lab=#net1}
N -260 -230 -170 -230 {lab=#net1}
N 130 -250 240 -250 {lab=#net2}
N 240 -250 240 -230 {lab=#net2}
N 240 -230 320 -230 {lab=#net2}
N 620 -250 730 -250 {lab=#net3}
N 730 -250 730 -230 {lab=#net3}
N 730 -230 810 -230 {lab=#net3}
N 1110 -250 1220 -250 {lab=#net4}
N 1220 -250 1220 10 {lab=#net4}
N 1220 10 1220 20 {lab=#net4}
N 1150 20 1220 20 {lab=#net4}
N 730 40 850 40 {lab=#net5}
N 730 10 730 40 {lab=#net5}
N 640 10 730 10 {lab=#net5}
N 250 30 340 30 {lab=#net6}
N 250 10 250 30 {lab=#net6}
N 140 10 250 10 {lab=#net6}
N -220 30 -160 30 {lab=#net7}
N -220 20 -220 30 {lab=#net7}
N -310 20 -220 20 {lab=#net7}
N -330 -340 -330 -270 {lab=DVDDD}
N -330 -340 1110 -340 {lab=DVDDD}
N 1110 -340 1110 -270 {lab=DVDDD}
N 620 -340 620 -270 {lab=DVDDD}
N 130 -340 130 -270 {lab=DVDDD}
N -610 60 -610 110 {lab=DVDDD}
N -610 110 850 110 {lab=DVDDD}
N 850 60 850 110 {lab=DVDDD}
N 340 50 340 110 {lab=DVDDD}
N -160 50 -160 110 {lab=DVDDD}
N -330 -210 -330 -110 {lab=DGNDD}
N 1110 -210 1110 -110 {lab=DGNDD}
N 620 -210 620 -110 {lab=DGNDD}
N 130 -210 130 -110 {lab=DGNDD}
N 1110 -270 1300 -270 {lab=DVDDD}
N 1300 -270 1300 110 {lab=DVDDD}
N 850 110 1300 110 {lab=DVDDD}
N -330 -110 130 -110 {lab=DGNDD}
N 130 -110 620 -110 {lab=DGNDD}
N 620 -110 1110 -110 {lab=DGNDD}
N 1100 -110 1100 -60 {lab=DGNDD}
N -610 -60 1100 -60 {lab=DGNDD}
N -610 -60 -610 0 {lab=DGNDD}
N -160 -60 -160 -10 {lab=DGNDD}
N 340 -60 340 -10 {lab=DGNDD}
N 850 -60 850 0 {lab=DGNDD}
C {fulladder.sym} -480 -240 0 0 {name=x1}
C {fulladder.sym} -20 -240 0 0 {name=x2}
C {fulladder.sym} 470 -240 0 0 {name=x3}
C {fulladder.sym} 960 -240 0 0 {name=x4}
C {fulladder.sym} 1000 30 2 0 {name=x5}
C {fulladder.sym} 490 20 2 0 {name=x6}
C {fulladder.sym} -10 20 2 0 {name=x7}
C {fulladder.sym} -460 30 2 0 {name=x8}
C {iopin.sym} -330 -340 3 0 {name=p1 lab=DVDDD}
C {ipin.sym} -330 -110 3 0 {name=p2 lab=DGNDD}
C {opin.sym} -330 -230 0 0 {name=p3 lab=S0}
C {opin.sym} 130 -230 0 0 {name=p4 lab=S1}
C {opin.sym} 620 -230 0 0 {name=p5 lab=S2}
C {opin.sym} 1110 -230 0 0 {name=p6 lab=S3}
C {opin.sym} 850 20 2 0 {name=p7 lab=S4}
C {opin.sym} 340 10 2 0 {name=p8 lab=S5}
C {opin.sym} -160 10 2 0 {name=p9 lab=S6}
C {opin.sym} -610 20 2 0 {name=p10 lab=S7}
C {ipin.sym} -630 -270 0 0 {name=p11 lab=A0}
C {ipin.sym} -170 -270 0 0 {name=p12 lab=A1}
C {ipin.sym} 320 -270 0 0 {name=p13 lab=A2}
C {ipin.sym} 810 -270 0 0 {name=p14 lab=A3}
C {ipin.sym} 1150 60 2 0 {name=p15 lab=A4}
C {ipin.sym} 640 50 2 0 {name=p16 lab=A5}
C {ipin.sym} 140 50 2 0 {name=p17 lab=A6}
C {ipin.sym} -310 60 2 0 {name=p18 lab=A7}
C {ipin.sym} -170 -250 0 0 {name=p20 lab=B1}
C {ipin.sym} 320 -250 0 0 {name=p21 lab=B2}
C {ipin.sym} -630 -250 0 0 {name=p22 lab=B0}
C {ipin.sym} 810 -250 0 0 {name=p23 lab=B3}
C {ipin.sym} 1150 40 2 0 {name=p24 lab=B4}
C {ipin.sym} 640 30 2 0 {name=p25 lab=B5}
C {ipin.sym} 140 30 2 0 {name=p26 lab=B6}
C {ipin.sym} -310 40 2 0 {name=p27 lab=B7}
C {ipin.sym} -630 -230 0 0 {name=p28 lab=C0}
C {opin.sym} -610 40 2 0 {name=p29 lab=C7}
