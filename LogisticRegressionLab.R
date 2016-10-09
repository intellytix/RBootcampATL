# RStudio Lab: Logistic Regression using 'glm' function in R
# Source: 
# Tbschirani & Hastie: 'Elements of Statistical Learning' (book). R Library: ISLR.
# http://statweb.stanford.edu/~tibs/ElemStatLearn/

# The Stock Market Data

#Library of all data
library(ISLR)

#Print names, dimension and summary of Smarket data file
names(Smarket)
dim(Smarket)
summary(Smarket)

# Plot all pairs of variables
pairs(Smarket)

# Correlation between variables
cor(Smarket)
cor(Smarket[,-9])

attach(Smarket)
plot(Volume)

# Logistic Regression
# Fit logistic regression model with flag 'family=binomial'
glm.fit=glm(Direction~Lag1+Lag2+Lag3+Lag4+Lag5+Volume,data=Smarket,family=binomial)
summary(glm.fit)
coef(glm.fit)
summary(glm.fit)$coef
summary(glm.fit)$coef[,4]

# Predictions from training data:
glm.probs=predict(glm.fit,type="response")
glm.probs[1:10]
contrasts(Direction)
glm.pred=rep("Down",1250)

#Predict classification: If probability > 0.5, decide on 'Up' direction, otherwise 'Down'
glm.pred[glm.probs>.5]="Up"

#Create table of number correct and false classifications
#of all 'Up' and 'Down' directions, calculate mean values
table(glm.pred,Direction)
(507+145)/1250
mean(glm.pred==Direction)

#Create training set with Year < 2005
train=(Year<2005)

#Create subset of all other data with Year >= 2005
Smarket.2005=Smarket[!train,]
dim(Smarket.2005)
Direction.2005=Direction[!train]

#Re-do prediction and classification
glm.fit=glm(Direction~Lag1+Lag2+Lag3+Lag4+Lag5+Volume,data=Smarket,family=binomial,subset=train)
glm.probs=predict(glm.fit,Smarket.2005,type="response")
glm.pred=rep("Down",252)
glm.pred[glm.probs>.5]="Up"
table(glm.pred,Direction.2005)
mean(glm.pred==Direction.2005)
mean(glm.pred!=Direction.2005)

#Perform fit with less variables:
glm.fit=glm(Direction~Lag1+Lag2,data=Smarket,family=binomial,subset=train)
glm.probs=predict(glm.fit,Smarket.2005,type="response")
glm.pred=rep("Down",252)
glm.pred[glm.probs>.5]="Up"
table(glm.pred,Direction.2005)
mean(glm.pred==Direction.2005)
106/(106+76)
predict(glm.fit,newdata=data.frame(Lag1=c(1.2,1.5),Lag2=c(1.1,-0.8)),type="response")
