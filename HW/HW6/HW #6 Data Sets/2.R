data(spam)

spm_size <- floor(.66*nrow(spam))
train_ind <-sample(seq_len(nrow(spam)), size = spm_size)

train <- spam[train_ind,]
test <- spam[-train_ind,]

# svm
require(kernlab)
tobj <- tune.svm(type ~ ., data = train[1:300,], gamma=10^(-6:-3), cost=10^(1:2))
Gamma <- tobj$best.parameters[[1]]
C <- tobj$best.parameters[[2]]

SVM_model <- svm(type ~ ., data=train, cost=C, gamma=Gamma, cross=10)
summary(SVM_model)

pred <- predict(SVM_model, test)
acc <- table(pred, test$type)
acc/sum(acc)*100

# NNet
require(nnet)
NN_model <- nnet(type~., data=train, size=10)
pred <- predict(NN_model, test[-58], type="class")
acc <- table(pred, test$type)
acc/sum(acc)*100
