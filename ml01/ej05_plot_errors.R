#!/usr/bin/Rscript

args <- commandArgs(trailingOnly = TRUE)

if (length(args) != 2) {
    message("USAGE: ./ej05_plot.R parallel_errors diagonal_errors")
    quit()
}

message("parallel")
message(args[1])

message("diagonal")
message(args[2])

parallel <- read.csv(args[1], header = TRUE)
diagonal <- read.csv(args[2], header = TRUE)

# parallel

# diagonal

# before pruning

minX <- min(parallel$n, diagonal$n)
maxX <- max(parallel$n, diagonal$n)

minY <- min(parallel$TestEBP, parallel$TrainEBP, diagonal$TrainEBP, diagonal$TestEBP)
maxY <- max(parallel$TestEBP, parallel$TrainEBP, diagonal$TrainEBP, diagonal$TestEBP)

png("test.png")
par(mar=c(4,4,1,1)) # par = parametros de plot, mar = margenes, c(bottom, left, top, right)
plot(diagonal$n
   , diagonal$TrainEBP
   , col = "red"
   , type = "o"
   , xlim = c(minX, maxX)
   , ylim = c(minY, maxY)
   , xlab = "Training set size"
   , ylab = "Error percentage"
   , lwd = 2
   , lty = 3)

lines(diagonal$n
    , diagonal$TestEBP
    , col = "red"
    , type = "o"
    , lwd = 2)

lines(parallel$n
    , parallel$TrainEBP
    , col = "green"
    , type = "o"
    , lwd = 2
    , lty = 3)

lines(parallel$n
    , parallel$TestEBP
    , col = "green"
    , type = "o"
    , lwd = 2)


