#!/usr/bin/Rscript

args <- commandArgs(trailingOnly = TRUE)

if (length(args) != 7) {
    message("USAGE: ./ej_c_plot.R trees_diagonal_errors trees_parallel_errors anns_errors bayes_diagonal_errors bayes_parallel_errors knn_diagonal_errors knn_parallel_errors")
    quit()
}

trees_diagonal <- read.csv(args[1], header = TRUE)
trees_parallel <- read.csv(args[2], header = TRUE)
anns           <- read.csv(args[3], header = FALSE)
bayes_diagonal <- read.csv(args[4], header = TRUE)
bayes_parallel <- read.csv(args[5], header = TRUE)

anns_diagonal  <- subset(anns, V1=="diagonal")
anns_parallel  <- subset(anns, V1=="parallel")

knn_diagonal <- read.csv(args[6], header = TRUE)
knn_parallel <- read.csv(args[7], header = TRUE)

minX <- min(trees_diagonal$d)
maxX <- max(trees_diagonal$d)

minY <- min(trees_diagonal$TestEBP, trees_parallel$TestEBP,
            anns_diagonal$V3, anns_parallel$V3,
            bayes_diagonal$Test, bayes_parallel$Test,
            knn_diagonal$Test, knn_parallel$Test)

maxY <- max(trees_diagonal$TestEBP, trees_parallel$TestEBP,
            anns_diagonal$V3, anns_parallel$V3,
            bayes_diagonal$Test, bayes_parallel$Test,
            knn_diagonal$Test, knn_parallel$Test)

# red       -> diagonal
# green     -> parallel
# solid     -> trees
# dashed    -> neural network
# dotted    -> naive bayes

# black solid  -> knn diagonal
# black dashed -> knn parallel


png("ej_c.png")
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

lines(knn_diagonal$d
    , knn_diagonal$Test
    , col = "black"
    , type = "o"
    , lwd = 2
    , lty = 1)

lines(knn_parallel$d
    , knn_parallel$Test
    , col = "black"
    , type = "o"
    , lwd = 2
    , lty = 2)

legend(x="topleft"
     , legend=c("DT Diagonal", "DT Parallel", "ANN Diagonal", "ANN Parallel", "NB Diagonal", "NB Parallel", "KNN Diagonal", "KNN Parallel")
     , col=c("red", "green", "red", "green", "red", "green", "black", "black")
     , lwd=2
     , lty=c(1, 1, 2, 2, 3, 3, 1, 2))



