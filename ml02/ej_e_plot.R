#!/usr/bin/Rscript

args <- commandArgs(trailingOnly = TRUE)

if (length(args) != 3) {
    message("USAGE: ./ej07_plot.R parallel_errors diagonal_errors anns_errors")
    quit()
}

message("parallel")
message(args[1])

message("diagonal")
message(args[2])

parallel <- read.csv(args[1], header = TRUE)
diagonal <- read.csv(args[2], header = TRUE)
anns <- read.csv(args[3], header = FALSE)

anns_diagonal <- subset(anns, V1=="diagonal")
anns_parallel <- subset(anns, V1=="parallel")

minX <- min(parallel$d)
maxX <- max(parallel$d)


minY <- min(diagonal$TestEAP, parallel$TestEAP, anns_diagonal$V3, anns_parallel$V3)
maxY <- max(diagonal$TestEAP, parallel$TestEAP, anns_diagonal$V3, anns_parallel$V3)

# red -> diagonal
# green -> parallel
# solid -> decision tree
# dashed -> neural network

png("ej_e.png")
par(mar=c(4,4,1,1)) # par = parametros de plot, mar = margenes, c(bottom, left, top, right)
plot(diagonal$d
   , diagonal$TestEAP
   , col = "red"
   , type = "o"
   , xlim = c(minX, maxX)
   , ylim = c(minY, maxY)
   , xlab = "Dimensions"
   , ylab = "Error percentage"
   , lwd = 2
   , lty = 1)

lines(parallel$d
    , parallel$TestEAP
    , col = "green"
    , type = "o"
    , lwd = 2
    , lty = 1)

lines(anns_parallel$V2
    , anns_parallel$V3
    , col = "green"
    , type = "o"
    , lwd = 2
    , lty = 2)

lines(anns_diagonal$V2
    , anns_diagonal$V3
    , col = "red"
    , type = "o"
    , lwd = 2
    , lty = 2)
