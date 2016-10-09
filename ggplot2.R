## ---- setup_ggplot2
library(ggplot2)

## ---- load_diamond_ggplot2
diamonds = diamonds[sample(NROW(diamonds), size=1000),]
head(diamonds)

## ---- qplot_ggplot2
#these are equivalent:
#qplot(diamonds$carat, diamonds$price, data=diamonds)
#qplot(x=carat, y=price, data=diamonds)
qplot(carat, price, data=diamonds)

## ---- qplot_colour_ggplot2
qplot(carat, price, data=diamonds, colour=clarity)

## ---- qplot_overplotting_ggplot2
qplot(carat, price, data=diamonds, colour=clarity, alpha=I(1/2))

## ---- qplot_log_ggplot2
qplot(log(carat), log(price), data=diamonds, colour=clarity)

## ---- mtcars data set:
data(mtcars)
dim(mtcars)
head(mtcars, 1)

par(mfrow = c(1,2))
par(mar = c(4,4,2,2))

facet_names <- as_labeller(c(`0` =  "Automatic", `1` = "Manual"))

g1 <- ggplot(mtcars, aes(mpg)) + geom_histogram(binwidth = 1, col = "blue")
g2 <- g1 + facet_wrap(~am, labeller = facet_names)
g3 <- g2 + labs(title = "Miles per gallon for automatic or manual transmission") 
g4 <- g3 + labs(x = "Miles per gallon [mpg]", y = "frequency")
g4

#dev.copy(png, file = "/Users/markjack/data/plot_mtcars_mpg.png")
dev.off()
