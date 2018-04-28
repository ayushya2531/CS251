#set term postscript eps enhanced monochrome 20 dashed dashlength 1 lw 1.5
set terminal postscript eps enhanced color

set key samplen 2 spacing 1.5 font ",22"

set xtics font ",22"
set ytics font ",22"
set ylabel font ",25"
set xlabel font ",25"

set ylabel "Average exec. time"
set xlabel "Number of Elements in input"
set logscale xy
set ytic auto
set xtic auto

set key bottom right

set output "line_plot.eps"
plot 'line_data.data' every 1 using 1:($2) title "Threads = 1" with linespoints, \
     '' every 1 using 1:($3) title "Threads = 2" with linespoints pt 5 lc 4,\
     '' every 1 using 1:($4) title "Threads = 4" with linespoints lc 3,\
     '' every 1 using 1:($5) title "Threads = 8" with linespoints pt 5 lc 4,\
     '' every 1 using 1:($6) title "Threads = 16" with linespoints lc 3

