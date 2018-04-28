num_samples <- 50000
X <- rexp(num_samples, 0.2)
num_data <- data.frame(SerialN = seq(1, num_samples , 1), Data = sort(X))
plot(num_data)

mean.v <- vector(mode="numeric", length=0)
std.v <- vector(mode="numeric", length=0)

for(i in 1:100) { 
  nam <- paste("Y", i, sep = "")
  starta <- (i-1)*500 + 1
  enda <- i*500
  ind <- starta:enda
  assign(nam, X[ind])
  mean.v[i] <- mean(X[ind])
  std.v[i] <- sd(X[ind])
}

#n_data <- data.frame(SerialN = seq(1, 500 , 1), Data = mean.v)
#plot(n_data)



p1 <- dexp(Y1, 0.2)
p.plot <- data.frame(Values = Y1, Probability = p1)
plot(p.plot, main="pdf of Y1")
p2 <- dexp(Y2, 0.2)
p.plot <- data.frame(Values = Y2, Probability = p2)
plot(p.plot, main="pdf of Y2")
p3 <- dexp(Y3, 0.2)
p.plot <- data.frame(Values = Y3, Probability = p3)
plot(p.plot, main="pdf of Y3")
p4 <- dexp(Y4, 0.2)
p.plot <- data.frame(Values = Y4, Probability = p4)
plot(p.plot, main="pdf of Y4")
p5 <- dexp(Y5, 0.2)
p.plot <- data.frame(Values = Y5, Probability = p5)
plot(p.plot, main="pdf of Y5")


d1 <- pexp(Y1, 0.2)
p.plot <- data.frame(Values = Y1, Cummulative_Probability = d1)
plot(p.plot, main="cdf of Y1")
d2 <- pexp(Y2, 0.2)
p.plot <- data.frame(Values = Y2, Cummulative_Probability = d2)
plot(p.plot, main="cdf of Y2")
d3 <- pexp(Y3, 0.2)
p.plot <- data.frame(Values = Y3, Cummulative_Probability = d3)
plot(p.plot, main="cdf of Y3")
d4 <- pexp(Y4, 0.2)
p.plot <- data.frame(Values = Y4, Cummulative_Probability = d4)
plot(p.plot, main="cdf of Y4")
d5 <- pexp(Y5, 0.2)
p.plot <- data.frame(Values = Y5, Cummulative_Probability = d5)
plot(p.plot, main="cdf of Y5")

for(i in 1:5)
{
  message(sprintf("Mean of vector Y%d : %f", i, mean.v[i]))
  message(sprintf("Standard Deviation of vector Y%d : %f", i, std.v[i]))
}

tem <- round(mean.v * 100)/100
tab <- table(tem)
plot(tab, "h", xlab="Value", ylab="Frequency")


len <- length(unique(tem))
m <- min(tem)
mz <- max(tem)
xcols <- seq(from = m, to = mz, by = 0.01)
pdata <- rep(0, length(xcols));

for(i in 1:100)
{
  val=tem[i];
  indd = (val - m)*100 + 1
  pdata[indd] = pdata[indd] + 1/100 ; 
  
}

plot(xcols, pdata, "l", xlab="Z", ylab="f(Z)")

cdata <- rep(0, length(xcols))

cdata[1] <- pdata[1]

for(i in 2:length(xcols)){
  cdata[i] = cdata[i-1] + pdata[i]
}

plot(xcols, cdata, "o", col="blue", xlab="X", ylab="F(X)");

message(sprintf("The mean of means is : %f", mean(mean.v)))
message(sprintf("The mean of std. deviations is : %f", mean(std.v)))
