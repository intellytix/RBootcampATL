### Title: Back to basics: High quality plots using base R graphics
###    An interactive tutorial for the Davis R Users Group meeting on April 24, 2015
###
### Date created: 20150418
### Last updated: 20150423
###
### Author: Michael Koontz
### Email: mikoontz@gmail.com
###	Twitter: @michaeljkoontz
###
### Purpose: Introduce basic to intermediate plotting capabilities of base R graphics
###
### Basic methods
###		1) Basic scatterplot and labeling a plot (Line 44)
###		2) Plotting groups in different ways on the same plot (Line 72)
###		3) Adding a legend (Line 120)
###		4) Adding a best fit line (Line 150)
###		5) Adding a 95% confidence interval (Line 150)
###		6) Shaded confidence intervals (Line 223)
###		7) Bar plots (Line 260)
###		8) Error bars (Line 274)
###
### Intermediate methods
###   1) Using other graphics devices like pdf() (Line 324)
###   2) Using par() for multipanel plots (Line 380) 
###		3) Using par() for margin adjustments (Line 438)
###		4) Using axis() and mtext() (Line 484)
###		5) Pretty print from plotmath (Line 601)

# We'll start with the very tractable 'trees' dataset, which is built into R. It describes the girth, height, and volume of 31 black cherry trees.
trees
dim(trees)
head(trees)

# Remember how we access the columns of a data.frame:
trees$Girth
trees$Volume

#Basic plot function takes x argument and a y argument
#Default plot type is points, but you can change it to lines or both points and lines by adding the 'type' argument

plot(x=trees$Girth, y=trees$Volume)
plot(x=trees$Girth, y=trees$Volume, type="l")
plot(x=trees$Girth, y=trees$Volume, type="b")

# pch: 'plotting character' changes the type of point that is used (default is an open circle); remember pch=19!
plot(x=trees$Girth, y=trees$Volume, pch=19)

# main: adds a title
plot(x=trees$Girth, y=trees$Volume, pch=19, main="Girth vs. Volume for Black Cherry Trees")

# xlab: adds an x axis label
plot(x=trees$Girth, y=trees$Volume, pch=19, main="Girth vs. Volume for Black Cherry Trees", xlab="Tree Girth (in)")

# ylab: adds a y axis label
plot(x=trees$Girth, y=trees$Volume, pch=19, main="Girth vs. Volume for Black Cherry Trees", xlab="Tree Girth (in)", ylab="Tree Volume (cu ft)")

# las: rotates axis labels; las=1 makes them all parallel to reading direction
plot(x=trees$Girth, y=trees$Volume, pch=19, main="Girth vs. Volume for Black Cherry Trees", xlab="Tree Girth (in)", ylab="Tree Volume (cu ft)", las=1)

# col: select a color for the plotting characters
plot(x=trees$Girth, y=trees$Volume, pch=19, main="Girth vs. Volume for Black Cherry Trees", xlab="Tree Girth (in)", ylab="Tree Volume (cu ft)", las=1, col="blue")

# We can use the c() function to make a vector and have several colors, plotting characters, etc. per plot.

plot(x=trees$Girth, y=trees$Volume, pch=19, main="Girth vs. Volume for Black Cherry Trees", xlab="Tree Girth (in)", ylab="Tree Volume (cu ft)", las=1, col=c("black", "blue"))

plot(x=trees$Girth, y=trees$Volume, pch=c(1,19), main="Girth vs. Volume for Black Cherry Trees", xlab="Tree Girth (in)", ylab="Tree Volume (cu ft)", las=1, col="blue")

#------------
# Plotting by group
#------------

### Those different colors and plotting characters that we just saw were arbitrary. The 2-element vector of colors or plotting characters just repeats for the whole data frame. What if we want to have more meaningful coloration, with a different color for each group? 

### We'll use the iris dataset to illustrate one way to do this. This dataframe describes the sepal length, sepal width, petal length, petal width, and species for 150 different irises.

# First look at the data:
iris
head(iris)
dim(iris)
str(iris)

# We can extend the idea of passing a vector of colors to the col= argument in the plot() function call.

# Let's cheat first, and see what the finished product will look like. First I define a new object with the three colors that I want to use.
plot.colors <- c("violet", "purple", "blue")
plot.colors

# Here's the cheating bit: I just looked at this dataframe and saw that there are exactly 50 observations for each species.
iris

# I use the repeat function, rep() and the each= argument, to create a new vector with each element of plot.colors repeated 50 times in turn.
color.vector <- rep(x=plot.colors, each=50)
color.vector

plot(x=iris$Petal.Length, y=iris$Sepal.Length, pch=19, col=color.vector)

# Notice the lengths of the x-vector, the y-vector, and the color vector are all the same.
length(iris$Petal.Length)
length(iris$Sepal.Length)
length(color.vector)

# What if we want to automate the process? We can take advantage of the fact that the Species column is a factor. 
head(iris)
iris$Species
str(iris)
as.numeric(iris$Species)

plot.colors <- c("violet", "purple", "blue")

color.vector <- plot.colors[iris$Species]

dev.off() # Just clearing the present plots

plot(x=iris$Petal.Length, y=iris$Sepal.Length, pch=19, col=color.vector, main="Iris sepal length vs. petal length", xlab="Petal length", ylab="Sepal length", las=1)

#-----------
# Let's add a legend
#-----------

# We use the legend() function to add a legend to an existing plot

legend("topleft", pch=19, col=plot.colors, legend=unique(iris$Species))

# You can customize the legend if you wish.
plot(x=iris$Petal.Length, y=iris$Sepal.Length, pch=19, col=color.vector, main="Iris sepal length vs. petal length", xlab="Petal length", ylab="Sepal length", las=1)

# Here I pass a character vector to the legend= argument so that I can include the first letter of the species name
# The bty="n" argument suppresses the border around the legend. (A personal preference)
legend("topleft", pch=19, col=plot.colors, legend=c("I. setosa", "I. versicolor", "I. virginica"), bty="n")

# Italicize the labels in the legend using text.font=3
plot(x=iris$Petal.Length, y=iris$Sepal.Length, pch=19, col=color.vector, main="Iris sepal length vs. petal length", xlab="Petal length", ylab="Sepal length", las=1)

legend("topleft", pch=19, col=plot.colors, legend=c("I. setosa", "I. versicolor", "I. virginica"), bty="n", text.font=3)


#------------------
# Add a linear best fit line and confidence interval to a plot
#------------------

# We'll use a simple linear regression for this, but the general recipe is the same every time.
# The Recipe
#	1) Estimate the parameters of the best fit line
#	2) Make up your own x values that span the range of your data
#	3) Get your y values by applying your mathematical model (e.g. a straight line) with the best fit parameters to your fabricated x values
#	4) Plot these new y values against your fabricated x values.

# Save your model fit to an object. Here, we model Sepal.Length as a function of Petal.Length
model1 <- lm(Sepal.Length ~ Petal.Length, data=iris)

# Now we have the parameter estimates for our y=ax+b line. The estimate for (Intercept) is b, and the estimate for Petal.Length is a.
summary(model1)

# Make up our own x values; put them in a dataframe!
range(iris$Petal.Length)
xvals <- seq(from=1, to=7, by=0.1)
xvals
df <- data.frame(Petal.Length=xvals)
df

# Plot the actual data (in the iris dataframe)
# This code copied from above
plot.colors <- c("violet", "purple", "blue") 
color.vector <- plot.colors[iris$Species]

plot(x=iris$Petal.Length, y=iris$Sepal.Length, pch=19, las=1, main="Iris sepal length vs. petal length", xlab="Petal length", ylab="Sepal length", col=color.vector)

# Plot our best fit line. The x values are the Petal.Length column from the 'df' dataframe, and the y values are the 'fit' column from the CI dataframe. 
# Note that I use the lines() function, which just adds features to an existing plot.
# The lwd= argument changes the line width
lines(x=df$Petal.Length, y=CI$fit, lwd=2)

# Plot the confidence intervals
# The lty= argument changes the line type. There are 6 different line types, and you can just put a number 1 through 6 if you'd like. Default is "solid" (aka 1)
lines(x=df$Petal.Length, y=CI$lwr, lwd=2, lty="dashed", col="red")
lines(x=df$Petal.Length, y=CI$upr, lwd=2, lty="dashed", col="red")


#-----------------
# Base R plotting skills: Managing par()
#-----------------

# 2) You can change some fundamental plotting parameters by using par() before a plot.

# This is how you can:
#		Make multipanel plots
#		Give your plots more room in the inner margins
#		Give your plots some room in the outer margins

#---------------
# Multi-panel plots
#---------------

setosa <- subset(iris, subset=Species=="setosa")
versicolor <- subset(iris, subset=Species=="versicolor")
virginica <- subset(iris, subset=Species=="virginica")

# Using par(mfrow=c(number of rows, number of columns))
par(mfrow=c(1,2))

plot(x=iris$Petal.Length, y=iris$Sepal.Length, pch=19, las=1, main="All Irises", ylab="Sepal Length", xlab="Petal Length")

plot(x=setosa$Petal.Length, y=setosa$Sepal.Length, pch=19, las=1, col=plot.colors[1], main="I. setosa", ylab="Sepal Length", xlab="Petal Length")

plot(x=versicolor$Petal.Length, y=versicolor$Sepal.Length, pch=19, las=1, col=plot.colors[2], main="II. versicolor", ylab="Sepal Length", xlab="Petal Length")

plot(x=virginica$Petal.Length, y=virginica$Sepal.Length, pch=19, las=1, col=plot.colors[3], main="III. virginica", ylab="Sepal Length", xlab="Petal Length")

dev.off()
