data <- read.table("seeding.txt", header = T)
attach(data)
seeded <- data.frame(Control1, Target1)
seeded[length(seeded) + 1,] <- c(23.9,13.6)
seeded[length(seeded) + 1,] <- c(0.6,0.1)
unseeded <- data.frame(Control2, Target2)

# a 
diff_s <- seeded$Control1 - seeded$Target1
diff_u <- unseeded$Control2 - unseeded$Target2
boxplot(diff_s, diff_u, names=c("Seeded", "Unseeded"))
qqnorm(diff_s)
qqline(diff_s)
qqnorm(diff_u)
qqline(diff_u)

# normal distribution test
seeded_mean <- mean(seeded[,1] - seeded[,2])
seeded_sd <- sd(seeded[,1] - seeded[,2])
# -3.159259 9.712492
n <- length(seeded)
t <- qt(.95, n-1)
conf_l <- seeded_mean - t*seeded_sd
conf_r <- seeded_mean + t*seeded_sd
# confidence interval is (-64.48152, 58.163)
t_stat <- seeded_mean/seeded_sd
# 0.3252779 
# For seeded case t statistic is small

unseeded_mean <- mean(unseeded[,1] - unseeded[,2])
unseeded_sd <- sd(unseeded[,1] - unseeded[,2])
# -1.474074 6.377701
n <- length(unseeded)
t <- qt(.95, n-1)
conf_l <- unseeded_mean - t*unseeded_sd
conf_r <- unseeded_mean + t*unseeded_sd
# confidence interval is (-41.74129, 38.79315)
t_stat <- unseeded_mean/unseeded_sd
# 0.2311294
# For unseeded case t statistic is small

# rank test 
wilcox.test(diff_s)
# data:  diff_s
# V = 117, p-value = 0.1407
# alternative hypothesis: true location is not equal to 0
wilcox.test(diff_u)
# data:  diff_u
# V = 132, p-value = 0.1746
# alternative hypothesis: true location is not equal to 0

# b
seeded_tr <- sqrt(seeded)
unseeded_tr <- sqrt(unseeded)
diff_s <- seeded_tr$Control1 - seeded_tr$Target1
diff_u <- unseeded_tr$Control2 - unseeded_tr$Target2
boxplot(diff_s, diff_u, names=c("Seeded", "Unseeded"))
qqnorm(diff_s)
qqline(diff_s)
qqnorm(diff_u)
qqline(diff_u)
# Clearly sqrt transformation doesn't make a lot of difference
