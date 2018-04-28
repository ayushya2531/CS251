import os

with open('threads.txt','r') as f2:
	for line2 in f2:
		for thr in line2.split():
			 cmd = 'gnuplot -e \"filename=\'scatdata_' + thr + '.out\';outputfile=\'scatplot_' +thr+ '.eps\'\" scatter.p'
			 os.system(cmd)

cmd = 'gnuplot lineplot.p'
os.system(cmd)
cmd = 'gnuplot hist.p'
os.system(cmd)