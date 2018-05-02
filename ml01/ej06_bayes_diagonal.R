#!/usr/bin/Rscript

classify = function(x) {
    dist1 = (x[1] - 1)^2 + (x[2] - 1)^2 + (x[3] - 1)^2 + (x[4] - 1)^2 + (x[5] - 1)^2
    dist0 = (x[1] + 1)^2 + (x[2] + 1)^2 + (x[3] + 1)^2 + (x[4] + 1)^2 + (x[5] + 1)^2
    
    if (dist0 < dist1) {
        return(0)    
    } else {
        return(1)
    }
}

args <- commandArgs(trailingOnly = TRUE)

if (length(args) != 1) {
    message("USAGE: ./ej06_bayes_diagonal.R data_file")
    quit()
}

data <- read.csv(args[1], header = FALSE)

truth <- data[,6]
prediction <- apply(data[,-6], 1, classify)
total <- length(truth)
errors <- sum(truth != prediction)
cat(errors/total*100, sep = "\n")
