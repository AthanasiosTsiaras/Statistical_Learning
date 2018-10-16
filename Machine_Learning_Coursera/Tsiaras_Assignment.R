# Loading packages
library(caret)
library(ranger)
# Reading the data

testing <- read.csv("pml-testing.csv", header = TRUE)
training <- read.csv("pml-training.csv", header = TRUE)

# Creating train and test set from the training dataset
inTrain  <- createDataPartition(training$classe, p=0.7, list=FALSE)
Train <- training[inTrain, ]
Test  <- training[-inTrain, ]

#Removing empty columns and columns with minimal variance
empty_cols <- nearZeroVar(Train)
Train <- Train[,-empty_cols]
Test <- Test[,-empty_cols]

near_zero <- function(x){
        nas = 0
        for (i in 1:length(x)){
                if (is.na(x[i]==TRUE)){
                nas = nas+1
                
                }
        }
        if (nas > 0.95*length(col)){
                return(TRUE)
                
        }else{
                return(FALSE)
        }
}

Train <- Train[,!apply(Train,2,near_zero)]
Test <- Test[,!apply(Test,2,near_zero)]

# Removing identifier variables
Train <- Train[,-(1:5)]
Test <- Test[,-(1:5)]

# Models construction
# RF

mod1 <- train(classe~., data=Train, method="rf")
pred1 <- predict(mod1, Test)
rf_accu <- confusionMatrix(pred1, Test$classe)$overall[1]

mod2 <- train(classe~., data=Train, method="gbm", verbose=FALSE)
pred2 <- predict(mod2, Test)
gbm_accu <- confusionMatrix(pred2, Test$classe)$overall[1]

mod3 <- train(classe~., data=Train, method="rpart")
pred3 <- predict(mod3, Test)
rpart_accu <- confusionMatrix(pred3, Test$classe)$overall[1]

accu_compar<- data.frame(rf_accu=rf_accu,gbm_accu=gbm_accu, rpart_accu=rpart_accu)
print(accu_compar)

pred_final <- predict(mod1,testing)
print(pred_final)
