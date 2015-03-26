# a
lottery <- read.table("1970lottery.txt", header = T, sep=',')
day <- lottery$Day_of_year
draft <- lottery$Draft_No
plot(day, draft, xlab="Day of the year", ylab="Draft Number")

# b
pearson = cor(day, draft, method="pearson")
rank = sum((day - mean(day))*(draft - mean(draft)))/sqrt(sum((day - mean(day))^2)*sum((draft - mean(draft))^2))
spearman = cor(day, draft, method="spearman")
# pearson = -0.2260414
# spearman = -0.2258043

# c
count <- 0
for (i in 1:100)
{
  sample_draft <- sample(draft)
  p_sample <- cor(day, sample_draft)
  cat(i, pearson, p_sample, '\n')
  flush.console()
  if (p_sample > pearson)
    count = count + 1
}
# test is significant: count = 100

# d
lottery$Month = factor(lottery$Month, levels=month.abb)
boxplot(Draft_No, Month, data=lottery)

# e
count <- 0
for (i in 1:1000)
{
  sample_draft <- sample(draft, replace=T)
  p_sample <- cor(day, sample_draft)
  cat(i, pearson, p_sample, '\n')
  flush.console()
  if (p_sample > pearson)
    count = count + 1
}

count <- 0
for (i in 1:1000)
{
  sample_draft <- sample(draft, replace=T)
  s_sample <- cor(day, sample_draft)
  cat(i, spearman, s_sample, '\n')
  flush.console()
  if (p_sample > spearman)
    count = count + 1
}
# test is still significant