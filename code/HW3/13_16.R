# a
# Test hypothesis that rows and columns are independent
data <- matrix(c(79,10,10,58,8,34,49,9,42),3,3)
rows <- apply(data,1,sum)
cols <- apply(data,2,sum)
n <- sum(data)
E <- 1/n*outer(rows,cols)

chi_sq <- (data - E)^2/E

# p value with 4 degrees 
p_val <- 1 - pchisq(sum(chi_sq),4)
# 1.737411e-05
# Thus rows and columns are dependent
# From the matrix we see that cautions drivers prefer
# small cars the most (based on the proportion of the group), midroad group has next level of 
# affection, and finally explorer has the lowest proportion
# of favorable group