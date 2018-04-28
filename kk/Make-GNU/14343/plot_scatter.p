set term postscript eps enhanced monochrome 20 dashed dashlength 1 lw 1.5
set terminal postscript eps enhanced color

set key samplen 2 spacing 1 font ",22"

set xtics font ",22"
set ytics font ",22"
set ylabel font ",25"
set xlabel font ",25"

set format x "10^{%L}"
set xlabel "Number of Elements as input"
set ylabel "Exec time"
set logscale xy
set ytic auto
set xtic auto


set output outputfile
plot filename using 1:2 notitle with points pt 1 ps 1.5

