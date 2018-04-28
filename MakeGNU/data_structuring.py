from __future__ import division
import os

os.system('rm -f histdata.out')
os.system('rm -f lindata.out')
os.system('rm -f scatdata*.out')

with open('params.txt','r') as f:
	for line in f:
		for pars in line.split():
			cmd = 'echo -n \"' + pars + '\" >> histdata.out'
			os.system(cmd)
			cmd = 'echo -n \"' + pars + '\" >> lindata.out'
			os.system(cmd)
			with open('threads.txt','r') as f2:
				for line2 in f2:
					for thr in line2.split():
						sum1 = 0
						sum2 = 0
						sum3 = 0
						sum4 = 0
						nel = 0
						file = 'op_' + pars + '_' + thr + '.txt'
						file_n = 'op_' + pars + '_1.txt'
						list1 = [x.split(' ')[3] for x in open(file).readlines()]
						listn = [x.split(' ')[3] for x in open(file_n).readlines()]
						for timev, timevn in zip(list1,listn):
							cmd = 'echo \"' + pars + ' ' + timev + '\" >> scatdata_' + thr + '.out'
							os.system(cmd)
							sum1 = sum1 + float(timev)
							sum3 = sum3 + float(timev)/float(timevn)
							nel = nel + 1
						aver = sum1/nel
						aver_rat = sum3/nel
						for timev, timevn in zip(list1,listn):
							sum2 = sum2 + (float(timev) - aver)**2
							sum4 = sum4 + (float(timev)/float(timevn) - aver_rat)**2
						var	= sum2/nel
						var_rat = sum4/nel
						if thr == '1':
							bench = aver

						speedup = aver/bench
						#speedup_var = var*varinv + varinv*aver**2 + var*averinv**2
						cmd = 'echo -n \"' + ' ' + str(speedup) + ' ' + str(var_rat) + '\" >> histdata.out'
						os.system(cmd)
						cmd = 'echo -n \"' + ' ' + str(aver) + '\" >> lindata.out'
						os.system(cmd)
			cmd = 'echo \"\" >> histdata.out'
			os.system(cmd)
			cmd = 'echo \"\" >> lindata.out'
			os.system(cmd)