import numpy as np, csv, matplotlib.pyplot as plt, sys

def plot_arr(a, b, c, d):
    plt.plot(a, b, 'r.')
    plt.plot(a, c, 'b*')
    plt.xlabel('feature')
    plt.ylabel('label')
    plt.title('Plot')
    plt.grid(True)
    plt.savefig(d)
    plt.clf()

if len(sys.argv) != 3:
    print("Usage: python q2.py /path/to/train_file.csv /path/to/test_file.csv")
    sys.exit(1)

train_file = sys.argv[1]
test_file = sys.argv[2]

# Step-1
csvfile = open(train_file, 'r')
reader = csv.reader(csvfile, delimiter=',')
A = []
B = []
for (a, b) in reader:
    A = A + [a]
    B = B + [b]
A = A[1:]
B = B[1:]

A = list(map(lambda x: float(x), A))
B = list(map(lambda x: float(x), B))

n_train = len(A)

X_train = np.array([A])
Y_train = np.array([B])

A = np.ones((1, n_train))
New_X_train = np.hstack((A.T, X_train.T))

# Step-2
w = np.random.rand(2,1)

# Step-3
plot_arr(X_train, Y_train, (w.T).dot(New_X_train.T), "plot-a1.png")

# Step-4
w_direct = ((np.linalg.inv((New_X_train.T).dot(New_X_train))).dot(New_X_train.T)).dot(Y_train.T)

plot_arr(X_train, Y_train, (w_direct.T).dot(New_X_train.T), "plot-a2.png")

# Step-5
w = np.random.rand(2,1)
eta = 0.00000001
N = 2
for i in range(1, N):
    for j in range(0, n_train):
        # print(str(i) + " " + str(j))
        x = X_train[0][j]
        y = Y_train[0][j]
        a = [1, x]
        x1 = np.array([a]).T
        w = w - eta * (w.T.dot(x1) - y) * x1
        if j%1000 == 0:
            plot_arr(X_train, Y_train, (w.T).dot(New_X_train.T), "plot-b-" + str(i) + "-" + str(j) + ".png")

# Step-6
plot_arr(X_train, Y_train, (w.T).dot(New_X_train.T), "plot-b-final.png")

# Step-7
csvfile = open(test_file, 'r')
reader = csv.reader(csvfile, delimiter=',')
A_test = []
B_test = []
for (a, b) in reader:
    A_test = A_test + [a]
    B_test = B_test + [b]
A_test = A_test[1:]
B_test = B_test[1:]

A_test = list(map(lambda x: float(x), A_test))
B_test = list(map(lambda x: float(x), B_test))

n_test = len(A_test)

X_test = np.array([A_test])
Y_test = np.array([B_test])

A_test = np.ones((1, n_test))
New_X_test = np.hstack((A_test.T, X_test.T))

y_pred1 = New_X_test.dot(w).T
y_pred2 = New_X_test.dot(w_direct).T

e1 = y_pred1 - Y_test
e2 = y_pred2 - Y_test

rms1 = np.sqrt(np.mean(e1[0]**2))
rms2 = np.sqrt(np.mean(e2[0]**2))

print(rms1)
print(rms2)

