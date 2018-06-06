#!/usr/bin/Rscript

args <- commandArgs(trailingOnly = TRUE)

if (length(args) != 2) {
    message("USAGE: ./ej02_plot.R diagonal_errors parallel_errors")
    quit()
}

message("diagonal")
message(args[2])

message("parallel")
message(args[1])

diagonal <- read.csv(args[1], header = TRUE)
parallel <- read.csv(args[2], header = TRUE)

minX <- min(parallel$d, diagonal$d)
maxX <- max(parallel$d, diagonal$d)

minY <- min(diagonal$Train, diagonal$Validation, diagonal$Test,
            parallel$Train, parallel$Validation, parallel$Test)

maxY <- max(diagonal$Train, diagonal$Validation, diagonal$Test,
            parallel$Train, parallel$Validation, parallel$Test)

# red -> train
# green -> test
# solid > diagonal
# dashed -> parallel

png("ej02.png")
par(mar=c(4,4,1,1)) # par = parametros de plot, mar = margenes, c(bottom, left, top, right)
plot(diagonal$d
   , diagonal$Train
   , col = "red"
   , type = "o"
   , xlim = c(minX, maxX)
   , ylim = c(minY, maxY)
   , xlab = "Dimensions"
   , ylab = "Error percentage"
   , lwd = 2
   , lty = 1)

lines(diagonal$d
    , diagonal$Test
    , col = "green"
    , type = "o"
    , lwd = 2
    , lty = 1)

lines(parallel$d
    , parallel$Train
    , col = "red"
    , type = "o"
    , lwd = 2
    , lty = 3)

lines(parallel$d
    , parallel$Test
    , col = "green"
    , type = "o"
    , lwd = 2
    , lty = 3)

