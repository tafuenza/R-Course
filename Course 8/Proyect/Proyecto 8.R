
library(dplyr)
setwd("C:/Users/Casa/Desktop/R Curso/R-Course/Course 8/Proyect")
data <- read.table("pml-training.csv", header = TRUE, sep = ",", na.strings = c("","NA")) #Leer datos
data <- data[,-c(1,3,4,5,6,7)]
data <- data[ , colSums(is.na(data)) == 0]

#Plot

g <- ggplot(data, aes(x = user_name, fill = classe))
g <- g + geom_bar(position = "dodge", col = "black");
g <- g + labs(title = "Excercise by Name and Classe", x = "Names", y = "Frecuency");
g <- g+ theme(plot.title = element_text(hjust = 0.5)); g

data <- data[,-c(1)]
inTrain <- createDataPartition(y = data$classe, p = 0.7, list = FALSE)
training <- data[inTrain,]
testing <- data[-inTrain,]


nsv <- nearZeroVar(training,saveMetrics = TRUE); nsv

preobj <- preProcess(training, method = c("center","scale"))
training <- predict(preobj, training)

mod1 <- train(classe ~ ., data = training, method = "rf", trControl = trainControl(method = "cv", number = 3))
pred1 <- predict(mod1,training)
confusionMatrix(pred1, training$classe)
varImp(mod1)

preobj_testing <- preProcess(testing, method = c("center","scale"))
testing <- predict(preobj, testing)
pred2 <- predict(mod1,testing)
confusionMatrix(pred2, testing$classe)


save(mod1, file = "model training")
load(file = "model training", verbose = TRUE)

data_test <- read.table("pml-testing.csv", header = TRUE, sep = ",", na.strings = c("","NA"))
preobj_test <- preProcess(data_test, method = c("center","scale"))
data_test <- predict(preobj, data_test)
pred_test <- predict(mod1,data_test)
confusionMatrix(pred1, training$classe)