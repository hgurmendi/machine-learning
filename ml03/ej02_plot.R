#!/usr/bin/Rscript

args <- commandArgs(trailingOnly = TRUE)

if (length(args) != 5) {
    message("USAGE: ./ej02_plot.R trees_diagonal_errors trees_parallel_errors anns_errors bayes_diagonal_errors bayes_parallel_errors")
    quit()
}

message("Trees diagonal errors file:")
message(args[1])
message("Trees parallel errors file:")
message(args[2])
message("Neural network errors file:")
message(args[3])
message("Bayes diagonal errors file:")
message(args[4])
message("Bayes parallel errors file:")
message(args[5])

trees_diagonal <- read.csv(args[1], header = TRUE)
trees_parallel <- read.csv(args[2], header = TRUE)
anns           <- read.csv(args[3], header = FALSE)
bayes_diagonal <- read.csv(args[4], header = TRUE)
bayes_parallel <- read.csv(args[5], header = TRUE)

anns_diagonal  <- subset(anns, V1=="diagonal")
anns_parallel  <- subset(anns, V1=="parallel")

trees_diagonal
trees_parallel
bayes_diagonal
bayes_parallel
anns_diagonal
anns_parallel

minX <- min(trees_diagonal$d)
maxX <- max(trees_diagonal$d)

minY <- min(trees_diagonal$TestEBP, trees_parallel$TestEBP,
            anns_diagonal$V3, anns_parallel$V3,
            bayes_diagonal$Test, bayes_parallel$Test)

maxY <- max(trees_diagonal$TestEBP, trees_parallel$TestEBP,
            anns_diagonal$V3, anns_parallel$V3,
            bayes_diagonal$Test, bayes_parallel$Test)

# red       -> diagonal
# green     -> parallel
# solid     -> trees
# dashed    -> neural network
# dotted    -> naive bayes

png("ej02.png")
par(mar=c(4,4,1,1)) # par = parametros de plot, mar = margenes, c(bottom, left, top, right)
plot(trees_diagonal$d
   , trees_diagonal$TestEBP
   , col = "red"
   , type = "o"
   , xlim = c(minX, maxX)
   , ylim = c(minY, maxY)
   , xlab = "Dimensions"
   , ylab = "Test error percentage"
   , lwd = 2
   , lty = 1)

lines(trees_parallel$d
    , trees_parallel$TestEBP
    , col = "green"
    , type = "o"
    , lwd = 2
    , lty = 1)

lines(anns_diagonal$V2
    , anns_diagonal$V3
    , col = "red"
    , type = "o"
    , lwd = 2
    , lty = 2)

lines(anns_parallel$V2
    , anns_parallel$V3
    , col = "green"
    , type = "o"
    , lwd = 2
    , lty = 2)

lines(bayes_diagonal$d
    , bayes_diagonal$Test
    , col = "red"
    , type = "o"
    , lwd = 2
    , lty = 3)

lines(bayes_parallel$d
    , bayes_parallel$Test
    , col = "green"
    , type = "o"
    , lwd = 2
    , lty = 3)

