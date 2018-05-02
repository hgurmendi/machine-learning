#!/usr/bin/Rscript

classify = function(x) {
    if (x[1] < 0) {
        return(0)
    } else {
        return(1)
    }
}

args <- commandArgs(trailingOnly = TRUE)

if (length(args) != 1) {
    message("USAGE: ./ej06_bayes_parallel.R data_file")
    quit()
}

data <- read.csv(args[1], header = FALSE)

truth <- data[,6]
prediction <- apply(data[,-6], 1, classify)
total <- length(truth)
errors <- sum(truth != prediction)
cat(errors/total*100, sep = "\n")
