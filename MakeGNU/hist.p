#set terminal postscript eps enhanced color size 3.9,2.9
set term postscript eps enhanced monochrome 20 dashed dashlength 1 lw 1.5
set output "histplot.eps"

set key font ",22"
set xtics font ",22"
set ytics font ",22"
set ylabel font ",25"
set xlabel font ",25"
set xlabel "Num of elements"
set ylabel "Average speedup"
set yrange[0:4]
set ytic auto
set boxwidth 1 relative
set style data histograms
set style histogram cluster
set style fill pattern border
plot 'histdata.out' u 2:xticlabels(1) title "#thread = 1",\
'' u 4 title "#thread = 2" fillstyle pattern 7,\
'' u 6 title "#thread = 4" fillstyle pattern 12,\
'' u 8 title "#thread = 8" fillstyle pattern 14,\
'' u 10 title "#thread = 16" fillstyle pattern 9

#set terminal postscript eps enhanced color size 3.9,2.9
#set output "speedup_color.eps"
#plot 'speedup.out' u 2:xticlabels(1) title "Baseline",\
#'' u 3 title "Policy(A)" fillstyle pattern 7,\
#'' u 4 title "Policy(B)" fillstyle pattern 12,\
#'' u 5 title "Policy(C)" fillstyle pattern 14
#
set term postscript eps enhanced monochrome 20 dashed dashlength 1 lw 1.5
set output "hist_errorbar.eps"
set xtics rotate by -45
set style histogram errorbars lw 3
set style data histogram

plot 'histdata.out' u 2:3:xticlabels(1) title "#thread = 1",\
'' u 4:5 title "#thread = 2" fillstyle pattern 7,\
'' u 6:7 title "#thread = 4" fillstyle pattern 12,\
'' u 8:9 title "#thread = 8" fillstyle pattern 14,\
'' u 10:11 title "#thread = 16" fillstyle pattern 14
