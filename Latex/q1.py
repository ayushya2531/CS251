import sys
n = sys.argv[1]
b1 = sys.argv[2]
#print(type(n))
#print(type(b))
n.strip("0")
b1.strip("0")
b = 0
for index in range(len(b1)):
    c = b1[len(b1) - index - 1]
    v = ord(c) - 48
    b = b + v*10**(index)

flag = 0
n1d = 0
n2d = 0
if '.' in n:
    if len(n.split('.')) > 2:
	print('Not a valid number')
	flag = 1
    n1 = n.split('.')[0]
    n2 = n.split('.')[1]
else:
    n1 = n
    n2 = "0"
#print(n1,n2)
#if n1.isdigit()==0 or n2.isdigit()==0:
#    print('Not a valid number')
#    flag = 1
val = 37
flag1 = 0
flag2 = 0 
if flag == 0:
    for i in range(len(n1)):
	c = n1[len(n1) - i -1]
	if ord(c) >= 65 and ord(c) <= 90:
	    val = ord(c) - 55
	elif ord(c) >= 48 and ord(c) <= 57:
	    val = ord(c) - 48
	if val >= b:
	   flag1 = 1
	   print('Not a valid number')
	   break
	else:
	    n1d = n1d + val*b**(i)
    if flag1 == 0:
	 val = 37 
	 for i in range(len(n2)):
		c = n2[i]
		if ord(c) >= 65 and ord(c) <= 90:
		    val = ord(c) - 55
		elif ord(c) >= 48 and ord(c) <= 57:
		    val = ord(c) - 48
		if val >= b:
		   flag2 = 1
		   print('Not a valid number')
		   break
		else:
		    n2d = n2d + val*b**(i*(-1)-1)
if flag == 0 and flag1 == 0 and flag2 == 0:
    nd = n1d + n2d
    print(nd)
