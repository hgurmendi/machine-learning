#! /usr/bin/Rscript

args <- commandArgs(trailingOnly=TRUE)
if (length(args) != 1) {
    message("Missing file name")
    quit()
}

dataFile <- paste0(args[1], ".data")

outputFile <- paste0(args[1], ".png")

data <- read.csv(dataFile, header=FALSE)

# Class 0
c0 <- subset(data, V7==0)

# Class 1
c1 <- subset(data, V7==1)

# Get bounds
minX <- min(data$V1)
maxX <- max(data$V1)
minY <- min(data$V2)
maxY <- max(data$V2)

png(outputFile)
par(mar=c(4,4,1,1))
plot(c0$V1, c0$V2, xlim=c(minX, maxX), ylim=c(minY, maxY), col="green", xlab="X", ylab="Y")
par(new=T)
plot(c1$V1, c1$V2, xlim=c(minX, maxX), ylim=c(minY, maxY), col="red", xlab="X", ylab="Y")
abline(h=0, v=0)

message(paste0("Graph file: ", outputFile))
message("Plotting done")
