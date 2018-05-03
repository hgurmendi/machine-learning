#!/usr/bin/Rscript

args <- commandArgs(trailingOnly = TRUE)

if (length(args) != 2) {
    message("USAGE: ./ej07_plot.R parallel_errors diagonal_errors")
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

minX <- min(parallel$d, diagonal$d)
maxX <- max(parallel$d, diagonal$d)

minY <- min(parallel$TestEBP, parallel$TrainEBP, diagonal$TrainEBP, diagonal$TestEBP,
            parallel$TestEAP, parallel$TrainEAP, diagonal$TrainEAP, diagonal$TestEAP)
maxY <- max(parallel$TestEBP, parallel$TrainEBP, diagonal$TrainEBP, diagonal$TestEBP,
            parallel$TestEAP, parallel$TrainEAP, diagonal$TrainEAP, diagonal$TestEAP)


# rojo -> diagonal
# verde -> parallel

png("ej07_ebp.png")
par(mar=c(4,4,1,1)) # par = parametros de plot, mar = margenes, c(bottom, left, top, right)
plot(diagonal$d
   , diagonal$TrainEBP
   , col = "red"
   , type = "o"
   , xlim = c(minX, maxX)
   , ylim = c(minY, maxY)
   , xlab = "Training set size"
   , ylab = "Error percentage"
   , lwd = 2
   , lty = 3)

lines(diagonal$d
    , diagonal$TestEBP
    , col = "red"
    , type = "o"
    , lwd = 2)

lines(parallel$d
    , parallel$TrainEBP
    , col = "green"
    , type = "o"
    , lwd = 2
    , lty = 3)

lines(parallel$d
    , parallel$TestEBP
    , col = "green"
    , type = "o"
    , lwd = 2)

# after pruning

png("ej07_eap.png")
par(mar=c(4,4,1,1)) # par = parametros de plot, mar = margenes, c(bottom, left, top, right)
plot(diagonal$d
   , diagonal$TrainEAP
   , col = "red"
   , type = "o"
   , xlim = c(minX, maxX)
   , ylim = c(minY, maxY)
   , xlab = "Training set size"
   , ylab = "Error percentage"
   , lwd = 2
   , lty = 3)

lines(diagonal$d
    , diagonal$TestEAP
    , col = "red"
    , type = "o"
    , lwd = 2)

lines(parallel$d
    , parallel$TrainEAP
    , col = "green"
    , type = "o"
    , lwd = 2
    , lty = 3)

lines(parallel$d
    , parallel$TestEAP
    , col = "green"
    , type = "o"
    , lwd = 2)
