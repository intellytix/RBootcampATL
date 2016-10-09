library(caret) 
library(kernlab) 
library(e1071) 
inTrain <- createDataPartition(y=spam$type, p=0.75, list=FALSE) 
training <- spam[inTrain,] 
testing <- spam[!inTrain,] 
modelFit <- train(type ~., data=training, method = "glm") 

library(caret); data(faithful); set.seed(333) 
inTrain <- createDataPartition(y=faithful$waiting, p=0.5, list=FALSE)
trainFaith <- faithful[inTrain, ]; testFaith <- faithful[!inTrain, ] 
head(trainFaith) 
plot(trainFaith$waiting, trainFaith$eruptions, pch=19, col="blue", xlab="Waiting", ylab="Duration")
lm1 <- lm(eruptions ~ waiting, data=trainFaith) 
summary(lm1) 
plot(trainFaith$waiting, trainFaith$eruptions, pch=19, col="blue", xlab="Waiting", ylab="Duration")
lines(trainFaith$waiting, lm1$fitted, lwd=3)

set.seed(8953)
iris2 <- iris
iris2$Species <- NULL
kmeans.result <- kmeans(iris2, 3)
table(iris$Species, kmeans.result$cluster)
plot(iris2[c("Sepal.Length", "Sepal.Width")], 
     col = kmeans.result$cluster)
points(kmeans.result$centers[, c("Sepal.Length", "Sepal.Width")], col = 1:3, pch = 8, cex = 2)  