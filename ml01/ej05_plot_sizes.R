#!/usr/bin/Rscript

args <- commandArgs(trailingOnly = TRUE)

if (length(args) != 2) {
    message("USAGE: ./ej05_plot.R parallel_sizes diagonal_sizes")
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

minY <- min(parallel$SBP, parallel$SAP, diagonal$SBP, diagonal$SAP)
maxY <- max(parallel$SBP, parallel$SAP, diagonal$SBP, diagonal$SAP)

# rojo -> diagonal
# verde -> parallel

png("ej05_sbp.png")
par(mar=c(4,4,1,1)) # par = parametros de plot, mar = margenes, c(bottom, left, top, right)
plot(diagonal$n
   , diagonal$SBP
   , col = "red"
   , type = "o"
   , xlim = c(minX, maxX)
   , ylim = c(minY, maxY)
   , xlab = "Training set size"
   , ylab = "Tree size"
   , lwd = 2)

lines(parallel$n
    , parallel$SBP
    , col = "green"
    , type = "o"
    , lwd = 2)

# after pruning

png("ej05_sap.png")
par(mar=c(4,4,1,1)) # par = parametros de plot, mar = margenes, c(bottom, left, top, right)
plot(diagonal$n
   , diagonal$SAP
   , col = "red"
   , type = "o"
   , xlim = c(minX, maxX)
   , ylim = c(minY, maxY)
   , xlab = "Training set size"
   , ylab = "Tree size"
   , lwd = 2)

lines(parallel$n
    , parallel$SAP
    , col = "green"
    , type = "o"
    , lwd = 2)
