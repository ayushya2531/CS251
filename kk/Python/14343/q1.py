import sys

def toInt(x, b):
    t = 0
    if '0' <= x and x <= '9':
        t = ord(x) - ord('0')
    elif 'a' <= x and x <= 'z':
        t = 10 + ord(x) - ord('a')
    elif 'A' <= x and x <= 'Z':
        t = 10 + ord(x) - ord('A')
    else:
        t = 37
    if t >= b:
        print("Invalid Input")
        sys.exit(1)
    else:
        return t

if len(sys.argv) != 3:
    print("Usage: python q1.py N b")
    sys.exit(1)

N = sys.argv[1]
b = sys.argv[2]

b = int(b) # Change string b to integer
assert 2<=b and b<=36, "b is out of range"

X = [] # Before decimal point
Y = [] # After decimal point
i = 0

neg = False
if N[0] == '-':
    neg = True
    i += 1

while i < len(N):
    if N[i] == '.':
        i += 1
        break
    X = X + [toInt(N[i], b)]
    i += 1

while i < len(N):
    Y = Y + [toInt(N[i], b)]
    i += 1

ans = 0
i = len(X) - 1
t = 1
while i >= 0:
    ans += t*X[i]
    t *= b
    i -= 1

i = 0
t = 1/b
while i < len(Y):
    ans += t*Y[i]
    t /= b;
    i += 1

if neg:
    ans *= -1

print(ans)

