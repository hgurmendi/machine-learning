#! /usr/bin/Rscript

args <- commandArgs(trailingOnly=TRUE)
if (length(args) != 2) {
    message("USAGE: ./ej_b_plotter.R file_stem data|predic|test")
    quit()
}

file_stem <- args[1]
extension <- args[2]

dataFile <- paste(file_stem, extension, sep = ".")
message("Input:")
message(dataFile)

outputFile <- paste(file_stem, extension, "png", sep = ".")
message("Output:")
message(outputFile)

if (extension == "data" | extension == "test" ) {
    data <- read.csv(dataFile, header=FALSE)
} else if (extension == "predic") {
    data <- read.table(dataFile, header=FALSE)
} else {
    message("File extension not supported. It has to be either 'data' or 'predic'.")
    quit()
}

if (ncol(data) != 3) {
    message("File format not supported. Expected 2-dimensional vectors.")
    quit()
}

# Class 0
c0 <- subset(data, V3<=0.5)

# Class 1
c1 <- subset(data, V3>0.5)

# Get bounds
minX <- min(data$V1)
maxX <- max(data$V1)
minY <- min(data$V2)
maxY <- max(data$V2)

png(outputFile)
plot(c0$V1, c0$V2, xlim=c(minX, maxX), ylim=c(minY, maxY), col="green", xlab="X", ylab="Y")
par(new=T)
plot(c1$V1, c1$V2, xlim=c(minX, maxX), ylim=c(minY, maxY), col="red", xlab="X", ylab="Y")
abline(h=0, v=0)

