require(class)
banks <- read.table("banks.csv", header=T, sep=",")

# convert Education categorical variable
banks$Education1 <- rep(0, dim(banks)[1])
banks$Education2 <- rep(0, dim(banks)[1])
banks$Education3 <- rep(0, dim(banks)[1])
for (i in 1:dim(banks)[1]) {
  if (banks[i,8] == 1) {banks$Education1[i] <- 1}
  else if (banks[i,8] == 2) {banks$Education2[i] <- 1}
  else if (banks[i,8] == 3) {banks$Education3[i] <- 1}
}
banks <- banks[,-8] # remove Education variable

# drop variables
drops <- c("ID", "ZIP.Code")
banks_s <- banks[,!(names(banks) %in% drops)]
# append this customer to the end
customer <- data.frame(Age=40, Experience=10, Income=84, Family=2, CCAvg=2, Mortgage=0, Securities.Account=0, CD.Account=0, Online=1, CreditCard=1, Education1=0, Education2=1, Education=0)
banks_s[dim(banks_s)[1] + 1,] = customer
# normalize
normalize <- function (x) {
  return ( (x - min(x))/(max(x) - min(x)))
}
banks_n <- as.data.frame(lapply(banks_s[,-7], normalize))


spm_size <- floor(.6*nrow(banks))
train_ind <-sample(seq_len(nrow(banks)), size = spm_size)

train <- banks_n[train_ind,]
test <- banks_n[-train_ind,]
test <- test[-2001,] # drop this customer

# a
knn_model <- knn(train, banks_n[5001, ], banks[train_ind, 9], k=1)

# b
min_error = 100
min_k = -1 
for (i in 1:20) {
  knn_model <- knn(train, test, banks[train_ind, 9], k=i)
  pred <- table(knn_model, banks[-train_ind, 9])
  error <- (pred[2,1] + pred[1,2])/sum(pred)*100
  print(c(i, error))
  if (error < min_error) {
    min_error <- error
    min_k <- i
  }
}
min_error
min_k

# c
knn_model <- knn(train, test, banks[train_ind, 9], k=min_k)
pred <- table(knn_model, banks[-train_ind, 9])

# d
customer_class <- knn(train, banks_n[5001, ], banks[train_ind, 9], k=min_k)
knn_model <- knn(train, banks_n, banks[train_ind, 9], k=min_k)
pred <- table(knn_model, banks_n[, 9])

# e
# found at http://stackoverflow.com/a/20056357/2069858
split_data <- function(dat, props = c(.5, .3, .2), which.adjust = 1){
  stopifnot(all(props >= 0), which.adjust <= length(props))
  props <- props/sum(props)
  n <- nrow(dat)
  ns <- round(n * props)
  ns[which.adjust] <- n - sum(ns[-which.adjust])
  ids <- rep(1:length(props), ns)
  which.group <- sample(ids)
  split(dat, which.group)
}
banks_normed <- as.data.frame(lapply(banks_s, normalize))
d <- split_data(banks_normed)
new_train <- d$`1`
new_validate <- d$`2`
new_test <- d$`3`

for (i in 1:20) {
val_pred <- knn(new_train[,-7], new_validate[,-7], new_train[,7],k=i)
class_mtx <- table(val_pred, new_validate[,7])
print(c(i, (class_mtx[1,2] + class_mtx[2,1])/sum(class_mtx)*100))
}
# k=3 gives the best accuracy in validation set
train_pred <- knn(new_train[,-7], new_train[,-7], new_train[,7],k=3)
class_mtx <- table(train_pred, new_train[,7])
class_mtx/sum(class_mtx)*100

val_pred <- knn(new_train[,-7], new_validate[,-7], new_train[,7],k=3)
class_mtx <- table(val_pred, new_validate[,7])
class_mtx/sum(class_mtx)*100

test_pred <- knn(new_train[,-7], new_test[,-7], new_train[,7],k=3)
class_mtx <- table(test_pred, new_test[,7])
class_mtx/sum(class_mtx)*100
