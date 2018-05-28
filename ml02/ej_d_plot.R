#!/usr/bin/Rscript

args <- commandArgs(trailingOnly = TRUE)

if (length(args) != 1) {
    message("USAGE: ./ej_d_plot.R mse_file")
    quit()
}

data <- read.table(args[1], header=FALSE)

outfile <- paste(args[1], "png", sep=".")

names(data) <- c("mse", "mse_train", "mse_validation", "mse_test", "disc_train", "disc_validation", "disc_test", "weight_decay")

x <- 1:500

approx_train <- loess(data$mse_train~x, span=0.4)
approx_test <- loess(data$mse_test~x, span=0.4)

png(outfile)

par(mar=c(4,4,1,1))

min_y <- min(data$mse_train, data$mse_test)
max_y <- max(data$mse_train, data$mse_test)

plot(x, data$mse_train, col="red", bg="red", cex=0.5, pch=21, ylim=c(min_y, max_y),
xlab="Epoch", ylab="MSE", xaxt="n")
lines(predict(approx_train), col="red", lwd=2)

axis(1, at=seq(0,500,100), labels=c("0", "20000", "40000", "60000", "80000", "100000"))

points(x, data$mse_test, col="green", bg="green", cex=0.5, pch=21)
lines(predict(approx_test), col="green", lwd=2)

legend(x="topright", legend=c("Train", "Test"), col=c("red", "green"), lwd=2)

# Plot weight decay

outfileDecay <- paste(args[1], "decay", "png", sep=".")

min_y <- min(data$weight_decay)
max_y <- max(data$weight_decay)

approx_decay <- loess(data$weight_decay~x, span=0.4)

png(outfileDecay)
plot(x, data$weight_decay, col="black", bg="black", cex=0.5, pch=21, ylim=c(min_y, max_y),
xlab="Epoch", ylab="Decay")
lines(predict(approx_decay), col="black", lwd=2)




