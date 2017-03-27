#! /usr/bin/Rscript

data <- read.csv("xd.data", header=FALSE)

c0 <- subset(data, V3==0)
c1 <- subset(data, V3==1)

minX <- min(data$V1)
maxX <- max(data$V1)
minY <- min(data$V2)
maxY <- max(data$V2)

png("ej_a.png")
plot(c0$V1, c0$V2, xlim=c(minX, maxX), ylim=c(minY, maxY), col="green", xlab="X", ylab="Y")
par(new=T)
plot(c1$V1, c1$V2, xlim=c(minX, maxX), ylim=c(minY, maxY), col="red", xlab="X", ylab="Y")
points(x=c(-1, 1), y=c(-1, 1), pch=3, col="black")
abline(h=0, v=0)
dev.off()
