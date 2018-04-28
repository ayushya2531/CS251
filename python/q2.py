import numpy as np
import matplotlib.pyplot as plt
from sklearn.metrics import mean_squared_error
from math import sqrt
train = np.loadtxt(open('/home/vishnuvardhan/Downloads/train.csv','rb'),delimiter = ',', skiprows = 1)
#ytrain = np.loadtxt(open('/home/vishnuvardhan/Downloads/train.csv','rb'),delimiter = ',', skiprows = 1)
xtrain = np.asarray(train[:,0])
ytrain = np.asarray(train[:,1])
alpha = len(xtrain)
new_xtrain = np.ones((10000,2))
new_xtrain[:,1] = xtrain
xtrain = xtrain.reshape((alpha,1))
ytrain = ytrain.reshape((alpha,1))
#print("val",alpha)
#print(xtrain.shape,ytrain.shape)
#new_xtrain = np.ones((10000,2))
#new_xtrain[:,1] = xtrain
nxtraint = new_xtrain.transpose()
#print("xtrain__n",nxtraint.shape)
w = np.random.rand(2,1)
#print(w.shape)
y_pred = np.matmul(w.transpose(),new_xtrain.transpose())
y_pred = y_pred.transpose()
#print(y_pred.shape)
plt.figure(1)
plt.plot(xtrain, ytrain, 'b.', xtrain, y_pred, 'r-')
#plt.ion()
plt.show()

t1 = np.linalg.inv(np.matmul(new_xtrain.transpose(),new_xtrain))
t2 = np.matmul(new_xtrain.transpose(),ytrain)
w_direct = np.matmul(t1,t2)
#print("wdirect",w_direct.shape)
y_pred = np.matmul(w_direct.transpose(),new_xtrain.transpose())
y_pred = y_pred.transpose()
plt.figure(2)
plt.plot(xtrain, ytrain, 'b.', xtrain, y_pred, 'r-')
#plt.ion()
plt.show()

#c = np.ones((1,1))
eta = 0.00000001
for n_epoch in range(2):
    for j in range(len(xtrain)):
	#x1 = np.append(c,xtrain[j])
	xd = nxtraint[:,j]
	xd = xd.reshape(2,1)
	#xd = x1.transpose()
	#print(xd.shape)
	y = ytrain[j]
	#print(y.shape)
	temp = np.dot(w.transpose(),xd)-y
	temp2 = eta*temp
	#if j == 5:
	#    print(y.shape,temp.shape, temp2.shape,"helooo",xd.shape)
	#xd = x1.transpose()
	w = w - np.multiply(temp2,xd)
	#print(w.shape)
	if j%100 == 0:
	    y_pred = np.matmul(w.transpose(),new_xtrain.transpose())
	    y_pred = y_pred.transpose()
	    plt.figure(3)
	    plt.plot(xtrain, ytrain, 'b.', xtrain, y_pred, 'r-')
	    #plt.ion()
	    plt.show()
   
y_pred = np.matmul(w.transpose(),new_xtrain.transpose())
y_pred = y_pred.transpose()
plt.figure(4)
plt.plot(xtrain, ytrain, 'b.', xtrain, y_pred, 'r-')
#plt.ion()
plt.show()
#print(w.shape)

test = np.loadtxt(open('/home/vishnuvardhan/Downloads/test.csv','rb'),delimiter = ',', skiprows = 1)
#ytest = np.loadtxt(open('/home/vishnuvardhan/Downloads/test.csv','rb'),delimiter = ',', skiprows = 1, usecols = (1))
xtest = np.asarray(test[:,0])
ytest = np.asarray(test[:,1])
l2 = len(xtest)
new_xtest = np.ones((len(xtest),2))
new_xtest[:,1] = xtest
ytest = ytest.reshape(l2,1)
ypred1 = np.matmul(new_xtest,w)
ypred2 = np.matmul(new_xtest,w_direct)
#print(ytest.shape,ypred1.shape,ypred2.shape,w.shape)
rms1 = sqrt(mean_squared_error(ytest, ypred1))
rms2 = sqrt(mean_squared_error(ytest, ypred2))
print("RMSE 1 = ",rms1,"RMSE 2 =", rms2)
