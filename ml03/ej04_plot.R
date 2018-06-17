#!/usr/bin/Rscript

args <- commandArgs(trailingOnly = TRUE)

if (length(args) != 2) {
    message("USAGE: ./ej04_plot.R elipses_errors spirals_errors")
    quit()
}

elipses <- read.csv(args[1])
spirals <- read.csv(args[2])

# elipses

outfile <- paste(args[1], "png", sep=".")

min_x <- min(elipses$bins)
max_x <- max(elipses$bins)
min_y <- min(elipses$Training, elipses$Validation, elipses$Test)
max_y <- max(elipses$Training, elipses$Validation, elipses$Test)

x <- elipses$bins

approx_train <- loess(elipses$Training~x, span=0.4)
approx_validation <- loess(elipses$Validation~x, span=0.4)
approx_test <- loess(elipses$Test~x, span=0.4)

png(outfile)

par(mar=c(4,4,1,1))

plot(x, elipses$Training, col="red", bg="red", cex=0.5, pch=21, ylim=c(min_y, max_y),
xlim=c(min_x, max_x), xlab="Number of bins", ylab="Error percentage", xaxt="n")
lines(cbind(x, predict(approx_train)), col="red", lwd=2)

axis(1, seq(0,100,by=20), labels=c("0", "20", "40", "60", "80", "100"))

points(x, elipses$Test, col="green", bg="green", cex=0.5, pch=21)
lines(cbind(x, predict(approx_test)), col="green", lwd=2)

points(x, elipses$Validation, col="blue", bg="blue", cex=0.5, pch=21)
lines(cbind(x, predict(approx_validation)), col="blue", lwd=2)

legend(x="bottomleft", legend=c("Train", "Test", "Validation"), col=c("red", "green", "blue"), lwd=2)


# spirals

outfile <- paste(args[2], "png", sep=".")

min_x <- min(spirals$bins)
max_x <- max(spirals$bins)
min_y <- min(spirals$Training, spirals$Validation, spirals$Test)
max_y <- max(spirals$Training, spirals$Validation, spirals$Test)

x <- spirals$bins

approx_train <- loess(spirals$Training~x, span=0.4)
approx_validation <- loess(spirals$Validation~x, span=0.4)
approx_test <- loess(spirals$Test~x, span=0.4)

png(outfile)

par(mar=c(4,4,1,1))

plot(x, spirals$Training, col="red", bg="red", cex=0.5, pch=21, ylim=c(min_y, max_y),
xlim=c(min_x, max_x), xlab="Number of bins", ylab="Error percentage", xaxt="n")
lines(cbind(x, predict(approx_train)), col="red", lwd=2)

axis(1, seq(0,100,by=20), labels=c("0", "20", "40", "60", "80", "100"))

points(x, spirals$Test, col="green", bg="green", cex=0.5, pch=21)
lines(cbind(x, predict(approx_test)), col="green", lwd=2)

points(x, spirals$Validation, col="blue", bg="blue", cex=0.5, pch=21)
lines(cbind(x, predict(approx_validation)), col="blue", lwd=2)

legend(x="bottomleft", legend=c("Train", "Test", "Validation"), col=c("red", "green", "blue"), lwd=2)


