set term postscript eps enhanced monochrome 20 dashed dashlength 1 lw 1.5
set terminal postscript eps enhanced color

set key samplen 2 spacing 1 font ",22"

set xtics font ",22"
set ytics font ",22"
set ylabel font ",25"
set xlabel font ",25"

set format x "10^{%L}"
set xlabel "No. of Elements"
set ylabel "Execution time"
#set yrange[0:500]
#set xrange[0:5000]
set logscale xy
#set autoscale yfix
set ytic auto
set xtic auto


set output outputfile
plot filename using 1:2 notitle with points pt 1 ps 1.5

