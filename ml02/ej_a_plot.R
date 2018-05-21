#!/usr/bin/Rscript

args <- commandArgs(trailingOnly = TRUE)

if (length(args) != 2) {
    message("USAGE: ./ej_a_plot.R mse_file plot_file")
    quit()
}

epocas <- seq(400, 40000, 400)

data <- read.table(args[1], header=FALSE)

names(data) <- c("mse", "mse_train", "mse_validation", "mse_test", "disc_train", "disc_validation", "disc_test")

x <- 1:100

approx_train <- loess(data$mse_train~x, span=0.4)
approx_validation <- loess(data$mse_validation~x, span=0.4)
approx_test <- loess(data$mse_test~x, span=0.4)

png(args[2])

par(mar=c(4,4,1,1))

plot(x, data$mse_train, col="red", bg="red", cex=0.5, pch=21,
xlab="Epoch", ylab="MSE", xaxt="n")
lines(predict(approx_train), col="red", lwd=2)

axis(1, at=seq(0,100,25), labels=seq(0, 40000, 10000))

points(x, data$mse_validation, col="green", bg="green", cex=0.5, pch=21)
lines(predict(approx_validation), col="green", lwd=2)

points(x, data$mse_test, col="blue", bg="blue", cex=0.5, pch=21)
lines(predict(approx_test), col="blue", lwd=2)

legend(x="topright", legend=c("Train", "Validation", "Test"), col=c("red", "green", "blue"), lwd=2)

