# a
# Use the Chi-Square Test of Homogeneity
data <- matrix(c(51,14,38,38,16,46),3,2)
Rsum <- apply(data,1,sum) 
Csum <- apply(data,2,sum) 
n <- sum(data) 

# so the matrix E is given by
E <- 1/n * outer(Rsum,Csum)

# chi-square statistic 
chi_sq <- (data - E)^2 / E
chi_sq_stat <- sum(chi_sq)
# 2.75038

# p_val for chi square with two degrees 
p_val <- 1 - pchisq(sum(chi_sq),2)
# 0.2527915


# ---------------------
# b
# all population
p <- 105.37/205.37
O <- c( 103 , 100 )
E <- 203 * c( 1-p , p )
chi_sq_stat <- sum( (O-E)^2 / E )
p_val <- 1 - pchisq(chi_sq_stat,1)
# 0.5596854

# just flying army
O <- c( 65 , 54 )
E <- 119 * c( 1-p , p )
chi_sq_stat <- sum( (O-E)^2 / E )
p_val <- 1 - pchisq(chi_sq_stat,1)
# 0.1956478

# just flying fighters 
O <- c( 51 , 38 )
E <- 89 * c( 1-p , p )
chi_sq_stat <- sum( (O-E)^2 / E )
p_val <- 1 - pchisq(chi_sq_stat,1)
# 0.1041131

# Use binomial approximation to get 38 females from population of 89
pbin <- pbinom(38, 89, p)
# 0.06427619

# All tests suugest that differre suggest that differences are due to chance 