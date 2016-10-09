# RStudio Lab: Linear Regression and Multiple Linear Regression
# Source: 
# Tbschirani & Hastie: 'Elements of Statistical Learning' (book). R Library: ISLR.
# http://statweb.stanford.edu/~tibs/ElemStatLearn/

#Library of all data
library(ISLR)

#The Boston housing data
library(MASS)

# Simple Linear Regression
fix(Boston)
names(Boston)

###lm.fit=lm(medv~lstat)
#Linear regression fit of outcome variable 'medv' and predictor variable 'lstat':
lm.fit=lm(medv~lstat,data=Boston)
#Alternative:
attach(Boston)
lm.fit=lm(medv~lstat)
#Print information of linear regression fit:
lm.fit
#Print statistics information:
summary(lm.fit)
names(lm.fit)
#Print regression coefficients:
coef(lm.fit)
#Print confidence intervals:
confint(lm.fit)

#Do the prediction:
predict(lm.fit,data.frame(lstat=(c(5,10,15))), interval="confidence")
predict(lm.fit,data.frame(lstat=(c(5,10,15))), interval="prediction")

#Plot the actual data:
plot(medv~lstat)
#Include linear regression line in plot:
abline(lm.fit)
abline(lm.fit,lwd=3)
abline(lm.fit,lwd=3,col="red")

plot(lstat,medv,col="red")
plot(lstat,medv,pch=20)
plot(lstat,medv,pch="+")
plot(1:20,1:20,pch=1:20)

#Create 4 plots in a panel layout:
par(mfrow=c(2,2))
plot(lm.fit)
plot(predict(lm.fit), residuals(lm.fit))
plot(predict(lm.fit), rstudent(lm.fit))
plot(hatvalues(lm.fit))
which.max(hatvalues(lm.fit))

# Multiple Linear Regression
# Linear fit of outcome 'medv' to two predictor variables 'lstat' and 'age':
lm.fit=lm(medv~lstat+age,data=Boston)
summary(lm.fit)
# Linear fit of outcome 'medv' to all predictors:
lm.fit=lm(medv~.,data=Boston)
summary(lm.fit)
# Linear fit of outcome 'medv' to all predictors:
lm.fit1=lm(medv~.-age,data=Boston)
summary(lm.fit1)
# Update fit removing predictor 'age' and 'indus' 
# ('indus' not being statistically significant, large p-value):
lm.fit1=update(lm.fit, ~.-age-indus)
summary(lm.fit1)

# Interaction Terms: Include interaction term between 'lstat' and 'age' during linear regression
summary(lm(medv~lstat*age,data=Boston))

