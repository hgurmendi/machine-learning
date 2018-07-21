#!/usr/bin/Rscript

args <- commandArgs(trailingOnly=TRUE)
if (length(args) != 2) {
    message("USAGE: ./ej_a_calc.R errors_file")
    quit()
}

input <- args[1]
output <- args[2]

data <- read.csv(input)

means <- c("Mean", mean(data$svml), mean(data$svmr), mean(data$dt), mean(data$nbc))
    
sds <- c("SD", sd(data$svml), sd(data$svmr), sd(data$dt), sd(data$nbc))

data <- rbind(data, means)
data <- rbind(data, sds)

write.table(data, file=output)

