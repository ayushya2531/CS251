#set term postscript eps enhanced monochrome 20 dashed dashlength 1 lw 1.5
set terminal postscript eps enhanced color

set key samplen 2 spacing 1.5 font ",22"

set xtics font ",22"
set ytics font ",22"
set ylabel font ",25"
set xlabel font ",25"

set xlabel "Num. of Elements"
set ylabel "Average Exec time"
#set yrange[0:750]
#set xrange[0:2700]
set logscale xy
set ytic auto
set xtic auto

set key bottom right

set output "linplot.eps"
plot 'lindata.out' every 1 using 1:($2) title "#threads = 1" with linespoints, \
     '' every 1 using 1:($3) title "#threads = 2" with linespoints pt 5 lc 4,\
     '' every 1 using 1:($4) title "#threads = 4" with linespoints lc 3,\
     '' every 1 using 1:($5) title "#threads = 8" with linespoints lc 3,\
     '' every 1 using 1:($6) title "#threads = 16" with linespoints lc 3
