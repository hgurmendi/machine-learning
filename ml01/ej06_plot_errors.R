#!/usr/bin/Rscript

args <- commandArgs(trailingOnly = TRUE)

if (length(args) != 2) {
    message("USAGE: ./ej06_plot.R parallel_errors diagonal_errors")
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

minX <- min(parallel$C, diagonal$C)
maxX <- max(parallel$C, diagonal$C)

minY <- min(parallel$TestEBP, parallel$TestEAP, diagonal$TestEBP, diagonal$TestEAP)
maxY <- max(parallel$TestEBP, parallel$TestEAP, diagonal$TestEBP, diagonal$TestEAP)

# rojo -> diagonal
# verde -> parallel

png("ej06_ebp.png")
par(mar=c(4,4,1,1)) # par = parametros de plot, mar = margenes, c(bottom, left, top, right)
plot(diagonal$C
   , diagonal$TestEBP
   , col = "red"
   , type = "o"
   , xlim = c(minX, maxX)
   , ylim = c(minY, maxY)
   , xlab = "Class overlapping"
   , ylab = "Test error percentage"
   , lwd = 2)

lines(parallel$C
    , parallel$TestEBP
    , col = "green"
    , type = "o"
    , lwd = 2)

png("ej06_eap.png")
par(mar=c(4,4,1,1)) # par = parametros de plot, mar = margenes, c(bottom, left, top, right)
plot(diagonal$C
   , diagonal$TestEAP
   , col = "red"
   , type = "o"
   , xlim = c(minX, maxX)
   , ylim = c(minY, maxY)
   , xlab = "Class overlapping"
   , ylab = "Test error percentage"
   , lwd = 2)

lines(parallel$C
    , parallel$TestEAP
    , col = "green"
    , type = "o"
    , lwd = 2)
