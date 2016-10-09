# Example for Statistical Measures 
####### Var, Covar and Corr #######
library(lattice)
library(caret)
library(AppliedPredictiveModeling)
library(ElemStatLearn)
library(stats)
#
set.seed(123)
x <- rnorm(n=1000)
head(x)
y <- rnorm(n=1000)
head(y)

z <- cbind (x,y)
head(z)
var(x, y, na.rm = FALSE, use = "na.or.complete")
#var(x, y, na.rm = TRUE)
cov(x, y, use = "na.or.complete", method = c("pearson", "kendall", "spearman"))
#cor(x, y, use = "na.or.complete", method = c("pearson", "kendall", "spearman"))
sd(x, na.rm = TRUE)
mean(x, na.rm = TRUE)
median(x, na.rm = TRUE)
range(x, na.rm=T)
summary(z)

################## Density #################
## Probability Density Function or(PDF), or Probability Density of the variable
data(mtcars)
histogram(mtcars$mpg)
mpgdens <- density(mtcars$mpg)

## This produces Density Plot
plot(mpgdens)
# This produces Histogram with Density Overlay
hist(mtcars$mpg, col='grey', freq=FALSE)
lines(mpgdens)

############## Data Correlation ################
names(iris)     
plot(iris[-5])
with(iris, cor(Petal.Width, Petal.Length))

iris.cor <- cor(iris[-5])
str(iris.cor)
head(iris.cor)
iris.cor['Petal.Width', 'Petal.Length']

# Creating a normal distribution with mean = 1 and std = 1
set.seed(2)
x <- rnorm(100, mean = 1, sd = 1 )
summary(x)
mean(x)
sd(x)

##### Variance ############
nosim <- 1000
n <- 10
apply(matrix(rnorm(nosim * n), nosim), 1, mean)
sd(apply(matrix(rnorm(nosim * n), nosim), 1, mean))
1 / sqrt(n)

nosim <- 1000
n <- 10
sd(apply(matrix(runif(nosim * n), nosim), 1, mean))
1 / sqrt(12 * n)

nosim <- 1000
n <- 10
sd(apply(matrix(rpois(nosim * n, 4), nosim), 1, mean))
2 / sqrt(n)

nosim <- 1000
n <- 10
sd(apply(matrix(sample(0 : 1, nosim * n, replace = TRUE), nosim), 1, mean))
1 / (2 * sqrt(n))

############## Common Distributions ###############
pnorm(1160, mean = 1020, sd = 50, lower.tail = FALSE)

pnorm(2.8, lower.tail = FALSE)

pbinom(2, size = 500, prob = 0.01)

ppois(2, lambda = 500 * 0.01)

pbinom(4, size = 5, prob = 0.5)

############### Asymptotics ##########
n <- 10000
means <- cumsum(rnorm(n))/(1:n)
library(ggplot2)
g <- ggplot(data.frame(x = 1:n, y = means), aes(x = x, y = y))
g <- g + geom_hline(yintercept = 0) + geom_line(size = 2)
g <- g + labs(x = "Number of obs", y = "Cumulative mean")
g

means <- cumsum(sample(0:1, n, replace = TRUE))/(1:n)
g <- ggplot(data.frame(x = 1:n, y = means), aes(x = x, y = y))
g <- g + geom_hline(yintercept = 0.5) + geom_line(size = 2)
g <- g + labs(x = "Number of obs", y = "Cumulative mean")
g

library(UsingR)
data(father.son)
x <- father.son$sheight
(mean(x) + c(-1, 1) * qnorm(0.975) * sd(x)/sqrt(length(x)))/12
(mean(x) + c(-2, 2) * qnorm(0.975) * sd(x)/sqrt(length(x)))/12
(mean(x) + c(-3, 3) * qnorm(0.975) * sd(x)/sqrt(length(x)))/12
