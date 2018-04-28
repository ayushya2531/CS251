x <- rexp(50000, 0.2)
plot(x, xlab="Random values", ylab="Exponential distribution")

y <- matrix(0, 500, 100)
for(i in 1:500)
{
	for(j in 1:100)
	{
		y[i, j] = x[(i-1)*100 + j]
	}
}

for(i1 in 1:5)
{
	# From here
	pdata <- rep(0, 100);

	for(i2 in 1:100)
	{
   		val = round(y[i1, i2], 0)
    	if(val <= 100)
    	{
       		pdata[val] = pdata[val] + 1.0/100.0
    	}
	}

	xcols <- c(0:99)

	str(pdata)
	str(xcols)

	plot(xcols, pdata, "l", xlab="X", ylab="f(X) - PDF")

	cdata <- rep(0, 100)

	cdata[1] <- pdata[1]

	for(i2 in 2:100)
	{
	    cdata[i2] = cdata[i2 - 1] + pdata[i2]
	}

	plot(xcols, cdata, "o", col="blue", xlab="X", ylab="F(X) - CDF")
	# Till here - taken from distrib_plot.r with minor modifications
}

mean <- rexp(500, 0.2)
variance <- rexp(500, 0.2)

for(i in 1:500)
{
	mean[i] = mean(y[i,]) 
	variance[i] = sd(y[i,]) 
}

print("Mean of 1st 5 vectors: ")
print(mean[1:5])

print("Variance of 1st 5 vectors: ")
print(variance[1:5])

# From here
pdata <- rep(0, 500);

for(i2 in 1:500)
{
	val = round(mean[i2], 0)
    if(val <= 500)
    {
       	pdata[val] = pdata[val] + 1.0/500.0
    }
}

xcols <- c(0:499)

str(pdata)
str(xcols)

plot(xcols, pdata, "l", xlab="X", ylab="f(X) - PDF")

cdata <- rep(0, 500)

cdata[1] <- pdata[1]

for(i2 in 2:500)
{
	cdata[i2] = cdata[i2 - 1] + pdata[i2]
}
	
plot(xcols, cdata, "o", col="blue", xlab="X", ylab="F(X) - CDF")
# Till here - taken from distrib_plot.r with minor modifications

mean_m = mean(mean)
variance_v = sd(mean)

print("Consider Z:")

print("Mean:")
print(mean_m)
print("Variance:")
print(variance_v)
