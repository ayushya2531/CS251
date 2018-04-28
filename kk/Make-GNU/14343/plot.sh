for i in $(cat threads.txt)
do
    gnuplot -e "filename='data_${i}.data';outputfile='dataplot_${i}.eps'" plot_scatter.p
done

gnuplot plot_line.p
gnuplot plot_bar.p
