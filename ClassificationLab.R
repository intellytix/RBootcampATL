# RStudio Lab: Classification with Linear / Quadratic Disciriminant Analysis (LDA, QDA), 
# k Nearest Neighbors (KNN), and Clustering
# Source: 
# Tbschirani & Hastie: 'Elements of Statistical Learning' (book). R Library: ISLR.
# http://statweb.stanford.edu/~tibs/ElemStatLearn/

# The Stock Market Data
library(ISLR)
library(MASS)

#General information with some plots on the data set:
names(Smarket)
dim(Smarket)
summary(Smarket)
pairs(Smarket)
cor(Smarket)
cor(Smarket[,-9])
attach(Smarket)
plot(Volume)

# Linear Discriminant Analysis:
# Predict direction of stock market from a number of materials:
lda.fit=lda(Direction~Lag1+Lag2,data=Smarket,subset=train)
lda.fit
# Plot histogram of LDA fit:
plot(lda.fit)

# Create training set with Year < 2005:
train=(Year<2005)

# Create subset of all other data and of outcome variable 'Direction' with Year >= 2005 (test set):
Smarket.2005=Smarket[!train,]
dim(Smarket.2005)
Direction.2005=Direction[!train]

# Perform prediction on test set: 
lda.pred=predict(lda.fit, Smarket.2005)
names(lda.pred)
lda.class=lda.pred$class
# Print first 5 rows of data frame of predictions:
data.frame(lda.pred[1:5,])

# Print table of correct and false predictions of predicted values versus true values:
table(lda.class,Direction.2005)
# Calculate probability of true classifications (true classification = 1, false classification = 0):
mean(lda.class==Direction.2005)

# Look at data frame of lda.pred
sum(lda.pred$posterior[,1] >= .5)
sum(lda.pred$posterior[,1] < .5)
lda.pred$posterior[1:20,1]
lda.class[1:20]
sum(lda.pred$posterior[,1]>.9)

# Extra:
# Quadratic Discriminant Analysis:
qda.fit=qda(Direction~Lag1+Lag2,data=Smarket,subset=train)
qda.fit
qda.class=predict(qda.fit,Smarket.2005)$class
table(qda.class,Direction.2005)
mean(qda.class==Direction.2005)

# Classification:
# K-Nearest Neighbors:
# Library for classification:
library(FNN)
# formerly: library(class)
# Create training and test data sets and training subset of variable 'Direction':
train.X=cbind(Lag1,Lag2)[train,]
test.X=cbind(Lag1,Lag2)[!train,]
train.Direction=Direction[train]
# Do prediction with kNN algorithm after fixing a seed when generating probability distribution:
set.seed(1)
knn.pred=knn(train.X,test.X,train.Direction, k=1)
# Print information on number / probability of correct and false classifications:
table(knn.pred,Direction.2005)
(83+43)/252
knn.pred=knn(train.X,test.X,train.Direction, k=3)
table(knn.pred,Direction.2005)
mean(knn.pred==Direction.2005)
