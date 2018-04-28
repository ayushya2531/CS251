import os

with open('params.txt','r') as f:
	for line in f:
		for pars in line.split():
			with open('threads.txt','r') as f2:
				for line2 in f2:
					for thr in line2.split():
						print "parametrs - %s %s" %(pars, thr)
						for iter in range(100):
							cmd = './Application '+ pars + ' ' + thr + ' >> op_' + pars + '_' + thr + '.txt'
							os.system(cmd)			

