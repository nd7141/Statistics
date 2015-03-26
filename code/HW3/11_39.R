tests <- read.table("11_39.txt", header=T)
test <- tests$Test
control <- tests$Control

# a
diffs <- test - control
plot(control, diffs)
# control is in linear relationship with diffs with negative slope

# b
mean_d <- mean(diffs)
sd_d <- sd(diffs)
n <- length(diffs)
alpha <- .05 # 95% confidence interval
s_p <- sqrt((var(test) + var(control))/2)
s_mean <- s_p*sqrt(2/n)
conf_l <- mean_d + qt(alpha/2, df=2*n - 2)*s_mean # confidence interval left bound 
conf_r <- mean_d - qt(alpha/2, df=2*n - 2)*s_mean
cat(mean_d, sd_d, conf_l, conf_r)
# mean sd conf_l conf_r
# -461.2857 757.8092 -905.2016 -17.36985

# c
median_d <- median(diffs)
conf <- sort(diffs)[qbinom(c(.025,.975), length(diffs), 0.5)] 
cat(median_d, conf)
# median conf_l con_r
# -368.5 -601 -7

# d 
# The sample sizes are fairly small (14 and 14), so in the absence of
# any prior knowledge concerning the adequacy of the assumption of a normal distribution,
# it would seem safer to use a nonparametric method
rank_t <- rank(c(test,control))[1:n]
rank_c <- rank(c(test,control))[(n+1):(2*n)]
R <- sum(rank_c)
Rp <- n*(2*n + 1) - R
Rst <- min(R, Rp)
critical = 160 # critical value for n1=n2=14 with .05 conf level
# nonparametric test rejects at the .05 significance level
#TODO perform t-test

